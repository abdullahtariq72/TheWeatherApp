//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/28/21.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var mainTempDeg: UILabel!
    @IBOutlet weak var mainTempImg: UIImageView!
    @IBOutlet weak var mainTempLbl: UILabel!
    @IBOutlet weak var tempSignImg: UIImageView!
    @IBOutlet weak var feelsLikeLbl: UILabel!
    @IBOutlet weak var sunriseLbl: UILabel!
    @IBOutlet weak var sunsetLbl: UILabel!
    @IBOutlet weak var uvLbl: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var msgParentView: UIView!
    @IBOutlet weak var infoMainView: UIView!
    @IBOutlet weak var subInfoView: UIView!
    @IBOutlet weak var parentMainview: UIView!
    
    //MARK: - Data Variables
    var weatherModel: WeatherModel!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        
        /**
         setup Navbar action items*/
        addLogoToNavigationBarItem()
        addNavBarButton(image: UIImage(named: "ic_back.png")!, direction: "left", buttonAction: #selector(didTapBackButton(_:)))
        
        /**
         Initiate Views and Actions for Controller*/
        setViews()
    }
    
    
    //MARK: - Setup All the Views theme and content for the IBoutlets content
    func setViews(){
        
        /**
         set up  UI Views for cell*/
        parentMainview.shadowView()
        infoMainView.shadowView()
        subInfoView.shadowView()
        msgParentView.shadowView()
        
        /**
         Image URL calling in Concurrent DispatchQueue Queue
         */
        let concurrentQueue = DispatchQueue(label: "myConcurrentQueueIconImg", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        concurrentQueue.async {
            APINetworkManager.sharedInstance.setImageFromUrl(ImageURL: K.WEATHER_ICON_BASEURL + String((self.weatherModel.dailyTempDetails?.weather![0].icon)!) + "@2x.png", completion: { image in
                self.mainTempImg.image = image!
            })
        }
        
        /**
         Setting up all the texual data in Cell ContentView items
         */
        
        if let temp = weatherModel.dailyTempDetails?.temp?.day{
            self.mainTempDeg.text = String(convertTemp(temp: temp))
        }
        
        if let feelsLike = weatherModel.currentTempDetails?.feelsLike{
            feelsLikeLbl.text = "Feels Like \(String(convertTemp(temp: feelsLike)))\(UserDefaultsHandler.sharedInstance.getTempType() == K.CELSIUS ? "C" : "F")"
        }
        
        mainTempLbl.text = weatherModel.dailyTempDetails?.weather![0].weatherDescription?.capitalized
        tempSignImg.image = UserDefaultsHandler.sharedInstance.getTempType() == K.CELSIUS ? UIImage(named: K.CELSIUS) : UIImage(named: K.FARENHEIT)
        
        sunsetLbl.text = String(AppUtility.millisToDate(millis: Double((weatherModel.dailyTempDetails?.sunset)!), format: DateFormats.TIME_FORMAT))
        sunriseLbl.text = String(AppUtility.millisToDate(millis: Double((weatherModel.dailyTempDetails?.sunrise)!), format: DateFormats.TIME_FORMAT))
        windLbl.text = String(format: "%.0f", Float(weatherModel.dailyTempDetails?.windSpeed ?? 0.0)) + " km/h"
        uvLbl.text = String(format: "%.0f", Float(weatherModel.dailyTempDetails?.uvi ?? 0.0))
        pressureLbl.text = String((weatherModel.dailyTempDetails?.pressure)!) + " HPa"
        humidityLbl.text = String((weatherModel.dailyTempDetails?.humidity)!) + "%"
        
        if let temp = weatherModel.dailyTempDetails?.temp?.day{
            msgLbl.text = "Its currently \(String(weatherModel.dailyTempDetails?.weather![0].weatherDescription?.capitalized ?? "")), \(String(convertTemp(temp: temp)))\(UserDefaultsHandler.sharedInstance.getTempType() == K.CELSIUS ? "C" : "F") and the sunset is at \(sunsetLbl.text ?? "") "
        }
    }
    
    // MARK: - IBOutlets Action
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: - Method to convert Celsius TO Farenheit and Vice versa
    func convertTemp(temp: Double)->Int{
        var convertedTemp = 0
        if UserDefaultsHandler.sharedInstance.getTempType() == K.CELSIUS{
            convertedTemp = (Int(String(format: "%.0f", Float(temp)))! - 32 ) * 5/9
        }
        else{
            convertedTemp = (Int(String(format: "%.0f", Float(temp)))! - 32 ) * 5/9
            convertedTemp = (Int(String(format: "%.0f", Float(convertedTemp)))! * 9/5) + 32
        }
        return convertedTemp
    }
}
