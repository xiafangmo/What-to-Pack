//
//  AppDelegate.swift
//  What to Pack
//
//  Created by MoXiafang on 2/29/16.
//  Copyright © 2016 Momo. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("Google-Maps-API-Key")
        return true
    }

}

