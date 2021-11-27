//
//  DashboardViewController.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/27/21.
//

import UIKit
import CoreLocation

class WeatherListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var noWeatherVIew: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var loctionImgView: UIImageView!
    
    //MARK: - Data Variables
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation? = nil
    var latitudeValue = ""
    var longituteValue = ""
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
         Initiate Views and Actions for Controller*/
        setViews()
        setActions()
        
    }
    
    
    //MARK: - Set Up Controller Views
    func setViews(){
        /**
         Seeting logo to NavBar for Controller*/
        self.addLogoToNavigationBarItem()
        
        noWeatherVIew.isHidden = false
        weatherTableView.isHidden = true
        
        searchBar.searchBarStyle = .minimal
        loctionImgView.image = loctionImgView.image?.withRenderingMode(.alwaysTemplate)
        loctionImgView.tintColor = Colors.APP_BLUE_COLOR
        
        self.weatherTableView.delegate = self
        self.weatherTableView.dataSource = self
        self.weatherTableView.separatorStyle = .none
        
        weatherTableView.register(UINib(nibName: NIBs.Weather, bundle: nil), forCellReuseIdentifier: Indentifiers.WeatherCell)
        
        locationManager.delegate = self
    }
    
    //MARK: - Set Up Custom Action
    func setActions(){
        let tapLocationView = UITapGestureRecognizer(target: self, action: #selector(action_getLocation))
        locationView.isUserInteractionEnabled = true
        locationView.addGestureRecognizer(tapLocationView)
        
    }
    
    //MARK: - IBActions for Custom Targets
    @IBAction func action_getLocation(sender: UITapGestureRecognizer) {
        startLocationServices()
        
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
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Indentifiers.WeatherCell, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        weatherTableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

// MARK: - VC Extention for Location Updates
extension WeatherListViewController: CLLocationManagerDelegate {
    
    func startLocationServices() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization() // This is where you request permission to use location services
        case .authorizedWhenInUse, .authorizedAlways:
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.startUpdatingLocation()
            }
        case .restricted, .denied:
            self.alertLocationAccessNeeded()
        @unknown default:
            break
        }
    }
    
    func alertLocationAccessNeeded() {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        
        let alert = UIAlertController(
            title: "Need Location Access",
            message: "Location access is required for including the location of the hazard.",
            preferredStyle: UIAlertController.Style.alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Location Access",
                                      style: .cancel,
                                      handler: { (alert) -> Void in
            UIApplication.shared.open(settingsAppURL,
                                      options: [:],
                                      completionHandler: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    // Monitor location services authorization changes
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            break
        case .authorizedWhenInUse, .authorizedAlways:
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.startUpdatingLocation()
            }
        case .restricted, .denied:
            self.alertLocationAccessNeeded()
        default:
            break
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            latitudeValue =  String(format: "%.3f", location.coordinate.latitude)
            longituteValue = String(format: "%.3f", location.coordinate.longitude)
            searchBar.text = latitudeValue + ", " + longituteValue
            print("Found user's location: \(location)")
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
}
