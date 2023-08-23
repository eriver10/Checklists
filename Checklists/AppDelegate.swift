//
//  AppDelegate.swift
//  Checklists
//
//  Created by Grey on 8/22/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

/*
 Notes from book for my own use later
 
 the easiest approach:
 
 1. Add a prototype cell to the table view in the storyboard.
 2. Set a reuse identifier on the prototype cell.
 3. Call tableView.dequeueReusableCell(withIdentifier:for:). This makes a new copy of the prototype cell if necessary, or, recycles an existing cell that is no longer in use.
 
 Once you have a cell, you should set it up with the data from the corresponding row and give it back to the table view.
 */
    
    
}

