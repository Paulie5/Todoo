//
//  AppDelegate.swift
//  Todoo
//
//  Created by Apple on 22/03/2019.
//  Copyright © 2019 Gravico. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        
        do{
            _ = try Realm()
        } catch {
            print("error initializing new realm, \(error)")
        }
       
        
        return true
    }
  
}

