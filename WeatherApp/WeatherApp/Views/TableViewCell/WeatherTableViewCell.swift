//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/27/21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var tempDegreeImg: UIImageView!
    @IBOutlet weak var tempImgView: UIImageView!
    @IBOutlet weak var weatherTextLbl: UILabel!
    
    
    //MARK: - Setup Table cell Items to View
    func setWeatherCell(dailyWeather: WeatherModel){
        if let temp = dailyWeather.dailyTempDetails?.temp?.day{
            self.tempLbl.text = String(convertTemp(temp: temp))
        }
        
        /**
         Image URL calling in Concurrent DispatchQueue Queue
         */
        let concurrentQueue = DispatchQueue(label: "myConcurrentQueueIconImg", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        concurrentQueue.async {
            APINetworkManager.sharedInstance.setImageFromUrl(ImageURL: K.WEATHER_ICON_BASEURL + String((dailyWeather.dailyTempDetails?.weather![0].icon)!) + "@2x.png", completion: { image in
                self.tempImgView.image = image!
            })
        }
        
        /**
         Setting up all the texual data in Cell ContentView items
         */
        dayLbl.text = dailyWeather.day
        dateLbl.text = dailyWeather.date
        weatherTextLbl.text = dailyWeather.dailyTempDetails?.weather![0].main
        tempDegreeImg.image = UserDefaultsHandler.sharedInstance.getTempType() == K.CELSIUS ? UIImage(named: K.CELSIUS) : UIImage(named: K.FARENHEIT)
        
    }
    
    //MARK: - NIBs Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        /**
         set up  UI Views for cell*/
        parentView.shadowView()
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
