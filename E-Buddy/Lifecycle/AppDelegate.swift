//
//  AppDelegate.swift
//  E-Buddy
//
//  Created by Edo Lorenza on 22/12/24.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let services: [UIApplicationDelegate] = [
        FirebaseSDK()
    ]
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        for service in services {
            _ = service.application?(application, didFinishLaunchingWithOptions: launchOptions)
        }
        return true
    }
}
