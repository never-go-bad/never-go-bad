//
//  AppDelegate.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 2/29/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
         Parse.setApplicationId("wNe6DP9lMT96m6TyB39b6x4X8t7z2Tr0nF5RpzH9", clientKey: "4I0keAG1YufRXDUhGXbFPxlLTxM67NjX0Sx54AJ8")
        
        let vc1 = UIStoryboard(name: "FoodList", bundle: nil).instantiateViewControllerWithIdentifier("FoodListNavigationController") as! UINavigationController
        let vc2 = UIStoryboard(name: "Recipe", bundle: nil).instantiateViewControllerWithIdentifier("RecipeNavigationController") as! UINavigationController
        let vc3 = UIStoryboard(name: "Settings", bundle: nil).instantiateViewControllerWithIdentifier("SettingsNavigationController") as! UINavigationController
            
        vc1.tabBarItem.title = "Inventory"
        vc1.tabBarItem.image = UIImage(named: "cart")

        vc2.tabBarItem.title = "Recipe"
        vc2.tabBarItem.image = UIImage(named: "equalizer")

        vc3.tabBarItem.title = "Settings"
        vc3.tabBarItem.image = UIImage(named: "gear")
            
        let tbc = UITabBarController()
        tbc.viewControllers = [vc1, vc2, vc3]
            
        self.window?.rootViewController = tbc
        self.window?.backgroundColor = UIColor.whiteColor()
        self.window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

