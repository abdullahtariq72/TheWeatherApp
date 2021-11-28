//
//  UserDefaultHandler.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/27/21.
//
import Foundation

class UserDefaultsHandler {
    
    let NUM_OF_DAYS = "num_of_days"
    let TEMP_TYPE = "temp_type"
    
    static let sharedInstance = UserDefaultsHandler()
    
    private init(){}
    
    func setNumOfDays(days: String) {
        UserDefaults.standard.set(days, forKey: NUM_OF_DAYS)
        UserDefaults.standard.synchronize()
    }
    
    func getNumOfDays() -> String {
        return UserDefaults.standard.string(forKey: NUM_OF_DAYS) ?? "8"
    }
    
    func setTempType(tempType: String) {
        UserDefaults.standard.set(tempType, forKey: TEMP_TYPE)
        UserDefaults.standard.synchronize()
    }
    
    func getTempType() -> String {
        return UserDefaults.standard.string(forKey: TEMP_TYPE) ?? K.CELSIUS
    }
}
