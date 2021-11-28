//
//  WeatherAppUtilityTest.swift
//  WeatherAppTests
//
//  Created by Abdullah Tariq on 11/28/21.
//

import XCTest
import Alamofire
@testable import WeatherApp

class WeatherAppUtilityTest: XCTestCase {

    func test_convertToFullDate(){
        let date = AppUtility.convertToFullDate(currentFormat: "yyyy-MM-dd", requiredFormat: "dd MMMM yyyy", date: "2021-04-01")
        XCTAssertEqual(date, "01 April 2021")
    }
    
    func test_getFormattedDate(){
        let date = AppUtility.getFormattedDate(format: "yyyy-MM-dd")
        XCTAssertEqual(date, "2021-11-28")
    }
    
    func test_daysBetweenDates(){
        let datesCount = AppUtility.daysBetweenDates(start: "2021-04-26", end: "2021-05-11")
        XCTAssertEqual(datesCount, 15)
    }
    
    func test_localToUTC(){
        let date = AppUtility.utcToLocal(dateStr: "2021-11-28 12:44:22", currentFormat: "yyyy-MM-dd hh:mm:ss")
        XCTAssertEqual(date, "2021-11-28 07:44:22")
    }
    
    func test_utcToLocal(){
        let date = AppUtility.utcToLocal(dateStr: "2021-11-28 12:44:22", currentFormat: "yyyy-MM-dd hh:mm:ss")
        XCTAssertEqual(date, "2021-11-28 05:44:22")
    }
    
    func test_jsonToDict(){
        let testJson = "{\n  \"name\": \"Abdullah\",\n  \"email\": \"abdullah.tariq7@gmail.com\"\n}"
        let testDict = ["name":"Abdullah","email":"abdullah.tariq7@gmail.com"]
        let dict = AppUtility.JSONStringToDict(jsonString: testJson) as! Dictionary<String, String>
        XCTAssertEqual(testDict, dict)
    }
    
    func test_DictToJsonStr(){
        let testJson = "{\"name\":\"Abdullah\",\"email\":\"abdullah.tariq7@gmail.com\"}"
        let testDict = ["name":"Abdullah","email":"abdullah.tariq7@gmail.com"]
        let dictStr = AppUtility.dictToJSONString(dictionary: testDict)
        XCTAssertEqual(testJson, dictStr)
    }
    
    func test_millisToDate(){
        let date = AppUtility.millisToDate(millis: 1638014706, format: DateFormats.TIME_FORMAT)
        XCTAssertEqual(date, "5:05 PM")
    }
    

    
}
