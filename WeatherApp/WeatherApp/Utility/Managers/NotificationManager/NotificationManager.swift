//
//  NotficationHandler.swift
//  ZensionComsumerApp
//
//  Created by Abdullah Tariq on 12/08/2020.
//  Copyright © 2020 Adnan Nasir. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit
class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    static let shared = NotificationManager()
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    private override init() {
        super.init()
        self.userNotificationCenter.delegate = self
        self.requestNotificationAuthorization(userNotificationCenter:self.userNotificationCenter)
    }
    
    
    
    func requestNotificationAuthorization(userNotificationCenter:UNUserNotificationCenter) {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        
        userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if error != nil {
            }
            if let error = error {
                print("Error: ", error)
            }
        }
    }
    func sendNotification(date: Date, title:String, body:String) {
        
        checkNotificationPermission()
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        notificationContent.sound = .default
        
        if let url = Bundle.main.url(forResource: "AppIcon", withExtension: "png") {
            if let attachment = try? UNNotificationAttachment(identifier: "AppIcon",url: url, options: nil) {
                notificationContent.attachments = [attachment]
            }
        }
        let triggerWeekly = Calendar.current.dateComponents([.weekday,.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: false)
        
        
        
        //         let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    func checkNotificationPermission(){
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { settings in
            switch settings.authorizationStatus {
            case .authorized, .provisional:
                print("authorized")
            case .denied:
                self.alertNotificationAccessNeeded()
            default:
                break
            }
        })
    }
    
    func alertNotificationAccessNeeded() {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        
        let alert = UIAlertController(
            title: "Need Notification Access",
            message: "Notification access is required for Weather Updates.",
            preferredStyle: UIAlertController.Style.alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Notification Access",
                                      style: .cancel,
                                      handler: { (alert) -> Void in
            UIApplication.shared.open(settingsAppURL,
                                      options: [:],
                                      completionHandler: nil)
        }))
        DispatchQueue.main.async {
            AppUtility.keyWindow?.rootViewController!.present(alert, animated: true, completion: nil)
        }
        
    }
}
