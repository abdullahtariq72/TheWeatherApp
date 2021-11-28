//
//  WeatherAPIManager.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/27/21.
//

import Foundation
import Alamofire

class WeatherAPIManager: NSObject{
    
    
    static let sharedInstance = WeatherAPIManager()
    
    
    //MARK: - Private Init
    private override init() {
        super.init()
    }
    
    //MARK: - Fetch Weather Data API Manager Level method
    func fetchWeatherData<T>(lat: String, lon: String, completion: @escaping (T?, _ error: String?)->()) where T: Codable {
        let params: Parameters = [
            K.LAT : lat,
            K.LON : lon,
            K.UNITS : K.WEATHER_UNIT,
            K.EXCLUDE : K.WEATHER_EXCLUDE,
            K.APPID : K.WEATHER_API_KEY
        ]
        
        APINetworkManager.sharedInstance.requestGetData(params: params, completion: { (weatherResponse: T?, message: String?) in
            message == nil ? completion(weatherResponse, nil) : completion(nil, message)
        })
    }
}
