//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/27/21.
//

import Foundation
import SwiftUI


class WeatherViewModel : NSObject {
    
    
    //MARK: - Data Variables
    var latitudeValue = ""
    var longituteValue = ""
    var netwokType: Bool!
    var parentVC: UIViewController!
    var weatherCurrentDetail: Current!
    private(set) var weatherResponseDailyList: [Daily]!
    
    //MARK: - Completion Didset DataModel
    private(set) var weatherDailyDataList : [WeatherModel]? {
        didSet {
            self.bindWeatherViewModelToController?(weatherDailyDataList)
        }
    }
    var bindWeatherViewModelToController : ((_ weatherList: [WeatherModel]?) -> ())? = nil
    
    //MARK: - Init Method
    init(lat: String, lon: String, vc: UIViewController, type: Bool) {
        super.init()
        self.latitudeValue = lat
        self.longituteValue = lon
        self.parentVC = vc
        netwokType = type
        netwokType == true ? self.fetchWeatherData() : getWeatherDataOffline()
    }
    
    //MARK: - Fetching Weather Data from APIs
    func fetchWeatherData(){
        WeatherAPIManager.sharedInstance.fetchWeatherData(lat: latitudeValue, lon: longituteValue, completion: { (weatherResponse: WeatherResponse?, message: String?) in
            
            if let _ = message{
                self.getWeatherDataOffline()
                return
            }
            if let response = weatherResponse{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.weatherCurrentDetail = response.current
                    self.weatherResponseDailyList = response.daily
                    self.bindWeatherViewModelToController?(self.setDataInWeatherDailyList())
                }
            }
        })
    }
    
    //MARK: - get offline data from Realm Storage
    func getWeatherDataOffline(){
        var weatherModelOffline = [WeatherModel]()
        let result = DBManager.get(fromEntity: WeatherObject.self)
        if result.count > 0{
            do {
                let decoder = JSONDecoder()
                let data = result[0].weatherObjectJson.data(using: String.Encoding.utf8, allowLossyConversion: false)
                if let jsonData = data {
                    weatherModelOffline = try decoder.decode([WeatherModel].self, from: jsonData)
                }
            }catch let error {
                print(error)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.bindWeatherViewModelToController?(weatherModelOffline)
        }
    }
    
    //MARK: - Prepare WeatherModel for Views
    func setDataInWeatherDailyList() -> [WeatherModel]{
        var weatherModel = [WeatherModel]()
        if let weatherList =  weatherResponseDailyList{
            let numOfDays = Int(UserDefaultsHandler.sharedInstance.getNumOfDays())
            if numOfDays! < 8{
                weatherResponseDailyList = Array(weatherList[..<numOfDays!])
            }else{
                
                for _ in 0..<(numOfDays! / 8) - 1 {
                    weatherResponseDailyList!.append(contentsOf: weatherList.prefix(numOfDays! - 8))
                }
                weatherResponseDailyList!.append(contentsOf: weatherList.prefix(numOfDays! - weatherResponseDailyList.count))
                
                let dates = AppUtility.getDates(format: DateFormats.EEEEMMMdyyyy, count: numOfDays!)
                weatherModel.removeAll()
                for i in 0...numOfDays!-1 {
                    let weatherItem = WeatherModel()
                    weatherItem.day = String(dates[i].split(separator: ",")[0])
                    weatherItem.date = String(dates[i].split(separator: ",")[1])
                    weatherItem.currentTempDetails = weatherCurrentDetail
                    weatherItem.dailyTempDetails = weatherResponseDailyList[i]
                    weatherModel.append(weatherItem)
                }
            }
        }
        saveDataToDB(weatherModel)
        return weatherModel
    }
    
    //MARK: - Saving Data to Realm Database
    func saveDataToDB(_ object: [WeatherModel]){
        let encodedData = try! JSONEncoder().encode(object)
        let jsonString = String(data: encodedData,
                                encoding: .utf8)

        let weatherJsonObject = WeatherObject()
        weatherJsonObject.weatherObjectJson = jsonString!
        DBManager.delete(DBManager.sharedInstance.realm.objects(WeatherObject.self))
        DBManager.add(weatherJsonObject)
    }
}
