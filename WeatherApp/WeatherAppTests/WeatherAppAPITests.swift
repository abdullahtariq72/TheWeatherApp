//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Abdullah Tariq on 11/26/21.
//

import XCTest
@testable import WeatherApp

class WeatherAppAPITests: XCTestCase {

    func test_get_weather_data(){
        let expectation = self.expectation(description: "get_weather_data")
        WeatherAPIManager.sharedInstance.fetchWeatherData(lat: "31.392", lon: "73.106", completion: { (weatherResponse: WeatherResponse?, message: String?) in
            XCTAssertNotNil(weatherResponse)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_fail_get_weather_data(){
        let expectation = self.expectation(description: "get_weather_data")
        WeatherAPIManager.sharedInstance.fetchWeatherData(lat: "", lon: "", completion: { (weatherResponse: WeatherResponse?, message: String?) in
            XCTAssertNotNil(weatherResponse)
            XCTAssertEqual(weatherResponse?.cod, "400")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
}
