//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/27/21.
//

import Foundation
import UIKit
import CoreLocation


class LocationManager: NSObject, CLLocationManagerDelegate{
    
    //MARK: - Variables
    static let sharedInstance = LocationManager()
    static var isAppTerminating = false
    static var isAppBackground = false
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation? = nil
    var locationUpdateCompletion: ((_ latitude: String, _ longitude: String) -> ())? = nil
    
    //MARK: - Private Init
    private override init() {
        super.init()
        locationManager.delegate = self
    }
    
    
    //MARK: - Initiate Location Services
    func startLocationServices() {
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1 //meters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    //MARK: - Observer Location Permissions
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            self.locationManager.requestAlwaysAuthorization()
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
    
    //MARK: - Observer Location Permissions Status
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
        
        AppUtility.keyWindow?.rootViewController!.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Alert Popup In case of No permissions
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
    
    //MARK: - Delegate to Provide Updated Locations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if !LocationManager.isAppTerminating && !LocationManager.isAppBackground{
                locationManager.stopUpdatingLocation()
                locationUpdateCompletion?(String(format: "%.3f", location.coordinate.latitude),String(format: "%.3f", location.coordinate.longitude))
            }else if LocationManager.isAppBackground && !LocationManager.isAppTerminating{
                _ = Timer(timeInterval: 200, repeats: true) { _ in
                    let calendar = Calendar.current
                    let date = calendar.date(byAdding: .minute, value: 1 , to: Date())
                    NotificationManager.shared.sendNotification(date: date!, title: K.APP_NAME, body: K.WEATHER_UPDATE)
                }
            }else{
                let calendar = Calendar.current
                let date = calendar.date(byAdding: .minute, value:10 , to: Date())
                NotificationManager.shared.sendNotification(date: date!, title: K.APP_NAME, body: K.WEATHER_UPDATE)
            }
            print("Found user's location: \(location)")
            
        }
    }
    
    //MARK: - Delegate to Provide Failed Location Error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    
}
