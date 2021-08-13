//
//  AppDelegate.swift
//  GCTest
//
//  Created by Santiago Borjon on 10/08/21.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var mainCoordinator: MainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //GoogleMaps API Key
        GMSServices.provideAPIKey("AIzaSyBnyXOcPwvfU_K93BrqASFGMhiEblWK3LE")
        
        //Init Window
        let navCon = CustomNavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navCon
        window?.makeKeyAndVisible()
        
        //Start Coordinator
        mainCoordinator = MainCoordinator(navCon)
        mainCoordinator?.start()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
}

