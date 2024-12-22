//
//  FirebaseSDK.swift
//  E-Buddy
//
//  Created by Edo Lorenza on 22/12/24.
//


import Foundation
import Firebase

class FirebaseSDK: NSObject{}

extension FirebaseSDK: UIApplicationDelegate {
    
    static let shared = FirebaseSDK()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        #if DEV
        guard let filePath = Bundle.main.path(forResource: "GoogleService-Info-DEV", ofType: "plist") else { return false }
        let options = FirebaseOptions(contentsOfFile: filePath)
        FirebaseConfiguration.shared.setLoggerLevel(.error)
        FirebaseApp.configure(options: options!)
        #else
        guard let filePath = Bundle.main.path(forResource: "GoogleService-Info-STAG", ofType: "plist")  else { return false }
        let options = FirebaseOptions(contentsOfFile: filePath)
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure(options: options!)
        #endif
        return true
    }
}
