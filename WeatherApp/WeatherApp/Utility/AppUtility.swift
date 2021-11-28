//
//  AppUtility.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/27/21.
//
import Foundation
import UIKit
import SHSnackBarView
import CryptoKit

class AppUtility {
    
    public init(){}
    static let keyWindow = UIApplication.shared.connectedScenes
        .lazy
        .filter { $0.activationState == .foregroundActive }
        .compactMap { $0 as? UIWindowScene }
        .first?
        .windows
        .first { $0.isKeyWindow }
    
    public static func showAlertControllerWithClick(title:String, message:String?, viewController:UIViewController , style: UIAlertController.Style = .alert, buttonsTitle:String, completion:((Bool)->Void)?) -> Void {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: buttonsTitle, style: UIAlertAction.Style.default) { (action) in
            completion?(true)
        })
        
        viewController.present(alert, animated: true, completion: nil)
    }
    public static func showAlertControllerWithTwoButtons(title:String, message:String?, viewController:UIViewController , style: UIAlertController.Style = .alert, buttonsTitle:String, completion:((Bool)->Void)?) -> Void {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        alert.addAction(UIAlertAction.init(title: buttonsTitle, style: UIAlertAction.Style.default) { (action) in
            completion?(true)
        })
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
    public static func showAlertWithDistructiveButton(message:String, title:String, btntitle:String, viewController:UIViewController, completion:((Bool)->Void)?) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        alert.addAction(UIAlertAction.init(title: btntitle, style: UIAlertAction.Style.destructive) { (action) in
            completion?(true)
        })
        viewController.present(alert, animated: true, completion: nil)
    }
    
    public static func dictToJSONString(dictionary: Dictionary<String, Any>) -> String {
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        return String(data: jsonData!, encoding: .utf8)!
    }
    
    public static func JSONStringToDict(jsonString: String) -> Dictionary<String, Any> {
        let jsonData = jsonString.data(using: .utf8)!
        let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
        if let dict = dictionary as? Dictionary<String, Any>{
            return dict
        }else{
            return Dictionary<String, Any>()
        }
    }
    
    public static func stringifyJSON(json: Any, prettyPrinted: Bool) -> String {
        var options: JSONSerialization.WritingOptions = []
        if prettyPrinted {
            options = JSONSerialization.WritingOptions.prettyPrinted
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: options)
            if let string = String(data: data, encoding: String.Encoding.utf8) {
                return string
            }
        } catch {
            print(error)
        }
        return ""
    }
    
    public static func convertToFullDate(currentFormat:String, requiredFormat:String,date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = currentFormat
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = requiredFormat
        let date: Date? = dateFormatterGet.date(from: date) as Date?
        if let _date = date{
            return dateFormatterPrint.string(from: _date as Date)
        }else{
            return ""
        }
    }
    
    public static func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: Date())
    }
    
    public static func daysBetweenDates(start: String, end: String) -> Int {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDate = dateFormatter.date(from:start)!
        let endDate = dateFormatter.date(from:end)!
        return Calendar.current.dateComponents([.day], from: startDate, to: endDate).day!
    }
    
    public static func showSnackBar(view: UIView, msg: String){
        let snackbarView = snackBar()
        
        snackbarView.showSnackBar(view: view, bgColor: Colors.APP_BLUE_COLOR, text: msg, textColor: UIColor.white, interval: 2)
    }
    
    public static func localToUTC(dateStr: String, currentFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentFormat
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = TimeZone.current
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = currentFormat
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    public static func utcToLocal(dateStr: String, currentFormat:String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = currentFormat
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    public static func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    
    public static func displayMsg(view: UIView, text: String){
        let screenSize: CGRect = UIScreen.main.bounds
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        myView.backgroundColor = UIColor.white
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        let label = UILabel(frame: CGRect(x: w / 2, y: h / 2, width: 300, height: 100))
        label.numberOfLines = 2
        label.center = CGPoint(x: w / 2, y: h / 2)
        label.textAlignment = .center
        label.text = text
        label.textColor = Colors.LIGHT_GRAY_COLOR
        view.addSubview(myView)
        view.addSubview(label)
    }
    
    public static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    public static func getDates(format: String, count: Int) -> Array<String>{
        var dates = Array<String>()
        var customDate = Date()
        let dateformat = DateFormatter()
        
        var modifiedDate = Calendar.current.date(byAdding: .day, value: -1, to: customDate)!
        customDate = modifiedDate
        dateformat.dateFormat = format
        dates.append(dateformat.string(from: customDate))
        
        for _ in 1...count-1 {
            modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: customDate)!
            customDate = modifiedDate
            dateformat.dateFormat = format
            dates.append(dateformat.string(from: customDate))
        }
        return dates
    }
    
    public static func millisToDate(millis: Double, format: String) -> String{
        let customDate = Date(timeIntervalSince1970: (millis))
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: customDate)
    }
    
  
    public static func stringtoDate(format: String, dateStr: String) -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: dateStr)!
    }
        
}

extension Bundle {
    
    var appName: String {
        return infoDictionary?["CFBundleName"] as! String
    }
    
    var bundleId: String {
        return bundleIdentifier!
    }
    
    var versionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    var buildNumber: String {
        return infoDictionary?["CFBundleVersion"] as! String
    }
    
}


extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
    
    var MD5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}

