//
//  DashboardViewController.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/27/21.
//

import UIKit
import GooglePlaces
import UserNotifications

class WeatherListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var noWeatherVIew: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var loctionImgView: UIImageView!
    
    //MARK: - Data Variables
    var latitudeValue = ""
    var longituteValue = ""
    var weatherModelList: [WeatherModel]!
    private var weatherViewModel : WeatherViewModel!
    let refreshControl = UIRefreshControl()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
         Initiate Views and Actions for Controller*/
        setViews()
        setActions()
        
    }
    
    //MARK: - ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if latitudeValue == "" && longituteValue == ""{
            fetchLocationUpdates()
        }
        self.weatherTableView.reloadData()
    }
    
    
    //MARK: - Set Up Controller Views
    func setViews(){
        /**
         Seeting logo to NavBar for Controller*/
        self.addLogoToNavigationBarItem()
        
        noWeatherVIew.isHidden = false
        weatherTableView.isHidden = true
        
        searchBar.delegate = self
        searchBar.searchTextField.clearButtonMode = .never
        searchBar.searchBarStyle = .minimal
        loctionImgView.image = loctionImgView.image?.withRenderingMode(.alwaysTemplate)
        loctionImgView.tintColor = Colors.APP_BLUE_COLOR
        
        refreshControl.addTarget(self, action:  #selector(refreshData), for: .valueChanged)
        weatherTableView.refreshControl = refreshControl
        
        self.weatherTableView.delegate = self
        self.weatherTableView.dataSource = self
        self.weatherTableView.separatorStyle = .none
        
        weatherTableView.register(UINib(nibName: NIBs.Weather, bundle: nil), forCellReuseIdentifier: Indentifiers.WeatherCell)
        
    }
    
    //MARK: - Set Up Custom Action
    func setActions(){
        let tapLocationView = UITapGestureRecognizer(target: self, action: #selector(action_getLocation))
        locationView.isUserInteractionEnabled = true
        locationView.addGestureRecognizer(tapLocationView)
    }
    
    //MARK: - IBActions for Custom Targets
    @IBAction func action_getLocation(sender: UITapGestureRecognizer) {
        fetchLocationUpdates()
    }
    
    //MARK: - Action to handle Pull To Refresh
    @objc func refreshData() {
        getWeatherDataFromViewModel(true)
    }
    
    //MARK: - Get Updates Device Locations
    func fetchLocationUpdates(){
        LocationManager.sharedInstance.startLocationServices()
        LocationManager.sharedInstance.locationUpdateCompletion = { [unowned self] (lat, long) in
            latitudeValue =  lat
            longituteValue = long
            searchBar.text = latitudeValue + ", " + longituteValue
            getWeatherDataFromViewModel(NetworkManagerUtility.sharedInstance.isConnectedToNetwork())
        }
    }
    
    //MARK: - Get Weather Data From APIs through ViewModel
    func getWeatherDataFromViewModel(_ type: Bool){
        self.showLoader()
        self.weatherViewModel =  WeatherViewModel(lat: latitudeValue, lon: longituteValue, vc:self, type: type)
        self.weatherViewModel.bindWeatherViewModelToController = { [unowned self] result in
            if let result = result{
                if result.count > 0{
                    self.weatherModelList = result
                    self.noWeatherVIew.isHidden = true
                    self.weatherTableView.isHidden = false
                    self.weatherTableView.reloadData()
                    
                }else{
                    AppUtility.showAlertControllerWithClick(title: K.APP_NAME, message: K.NO_INTERNET, viewController: self, style: .alert, buttonsTitle: K.OK, completion: { result in
                        
                    })
                }
                
            }
            self.refreshControl.endRefreshing()
            self.hideLoader()
        }
    }
}

// MARK: - VC Extention for TableView
extension WeatherListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = weatherModelList{
            return list.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Indentifiers.WeatherCell, for: indexPath) as! WeatherTableViewCell
        cell.setWeatherCell(dailyWeather: weatherModelList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let weatherDetailVC = Storyboards.MAIN.instantiateViewController(withIdentifier: Controllers.WEATHER_DETAIL) as! WeatherDetailViewController
        weatherDetailVC.weatherModel = weatherModelList[indexPath.row]
        self.navigationController?.pushViewController(weatherDetailVC, animated: true)
        weatherTableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - VC Extention for UISearchBar delegates handling for calling Google Places API
extension WeatherListViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if NetworkManagerUtility.sharedInstance.isConnectedToNetwork(){
            searchBar.resignFirstResponder()
            let acController = GMSAutocompleteViewController()
            acController.delegate = self
            present(acController, animated: true, completion: nil)
        }else {
            AppUtility.showAlertControllerWithClick(title: K.APP_NAME, message: K.NO_INTERNET, viewController: self, style: .alert, buttonsTitle: K.OK, completion: { result in
            })
        }
    }
}


// MARK: - VC Extention for Google Places API Delegates and Updates
extension WeatherListViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        latitudeValue =  String(format: "%.3f", place.coordinate.latitude)
        longituteValue = String(format: "%.3f", place.coordinate.longitude)
        searchBar.text = place.name
        dismiss(animated: true, completion: {
            self.getWeatherDataFromViewModel(true)
        })
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}
