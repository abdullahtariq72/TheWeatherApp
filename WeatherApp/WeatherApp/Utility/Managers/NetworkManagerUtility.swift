//
//  NetworkManagerUtility.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/28/21.
//

import Foundation
import Reachability
import Alamofire
class NetworkManagerUtility: NSObject {
    
    var reachability: Reachability!

    // Create a singleton instance
    static let sharedInstance: NetworkManagerUtility = { return NetworkManagerUtility() }()


    override init() {
        super.init()

        // Initialise reachability
        reachability = try? Reachability()

        // Register an observer for the network status
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )

        do {
            // Start the network status notifier
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
    }

    func stopNotifier() -> Void {
        do {
            // Stop the network status notifier
            try (NetworkManagerUtility.sharedInstance.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }

    // Network is reachable
    func isReachable(completed: @escaping (NetworkManagerUtility) -> Void) {
        if (NetworkManagerUtility.sharedInstance.reachability).connection != .unavailable {
            completed(NetworkManagerUtility.sharedInstance)
        }
    }

    // Network is unreachable
    func isUnreachable(completed: @escaping (NetworkManagerUtility) -> Void) {
        if (NetworkManagerUtility.sharedInstance.reachability).connection == .unavailable {
            completed(NetworkManagerUtility.sharedInstance)
        }
    }

    // Network is reachable via WWAN/Cellular
    func isReachableViaWWAN(completed: @escaping (NetworkManagerUtility) -> Void) {
        if (NetworkManagerUtility.sharedInstance.reachability).connection == .cellular {
            completed(NetworkManagerUtility.sharedInstance)
        }
    }

    // Network is reachable via WiFi
    func isReachableViaWiFi(completed: @escaping (NetworkManagerUtility) -> Void) {
        if (NetworkManagerUtility.sharedInstance.reachability).connection == .wifi {
            completed(NetworkManagerUtility.sharedInstance)
        }
    }
    
    func isConnectedToNetwork() -> Bool {
        return NetworkReachabilityManager()!.isReachable
        
    }
}
