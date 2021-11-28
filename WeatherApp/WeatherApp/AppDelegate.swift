//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/26/21.
//

import UIKit
import IQKeyboardManagerSwift
import GooglePlaces

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        setNavBarColor()
        GMSPlacesClient.provideAPIKey(K.GOOGLE_API_KEY)
        return true
    }
    
    func setNavBarColor(){
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = Colors.LIGHTGRAY_COLOR
            appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
                                              .foregroundColor: UIColor.black]
            // Customizing our navigation bar
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        LocationManager.isAppTerminating = true
        LocationManager.sharedInstance.startLocationServices()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        LocationManager.isAppBackground = true
        LocationManager.sharedInstance.startLocationServices()
    }


}

