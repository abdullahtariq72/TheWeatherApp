//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/27/21.
//

import Foundation
import UIKit

class WeatherModel: Codable {
    
    
    var day: String?
    var date: String?
    var weatherText: String?
    var currentTempDetails: Current?
    var dailyTempDetails: Daily?
    
    enum CodingKeys: String, CodingKey {
        case day, date, weatherText
        case currentTempDetails, dailyTempDetails
    }
}
