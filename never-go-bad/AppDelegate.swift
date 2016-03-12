//
//  AppDelegate.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 2/29/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import Parse
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
    
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

		Fabric.with([Crashlytics.self])

		Parse.setApplicationId("wNe6DP9lMT96m6TyB39b6x4X8t7z2Tr0nF5RpzH9", clientKey: "4I0keAG1YufRXDUhGXbFPxlLTxM67NjX0Sx54AJ8")

        self.window?.rootViewController = TabViewControllerHelper.createTabBarController()
		self.window?.backgroundColor = UIColor.whiteColor()
		self.window?.makeKeyAndVisible()

		let myNotificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Sound], categories: nil)
        application.registerUserNotificationSettings(myNotificationSettings)
        application.registerForRemoteNotifications()
//		UIApplication.sharedApplication().registerUserNotificationSettings(myNotificationSettings)
//		UIApplication.sharedApplication().registerForRemoteNotifications()
		// // Handle any action if the user opens the application throught the notification. i.e., by clicking on the notification when the application is killed/ removed from background.
//        if let aLaunchOptions = launchOptions { // Checking if there are any launch options.
//            // Check if there are any local notification objects.
//            if let notification = (aLaunchOptions as NSDictionary).objectForKey("UIApplicationLaunchOptionsLocalNotificationKey") as? UILocalNotification {
//                // Handle the notification action on opening. Like updating a table or showing an alert.
//                // notification.alertBody
//                UIAlertController(title: notification.alertTitle, message: notification.alertBody,preferredStyle: .ActionSheet)
//
//            }
		// }

		return true
	}

//    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
//    {
//        NotificationService.registerForNotifications()
//
//
//        return true
//    }
//
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

	func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
		// Point for handling the local notification when the app is open.
		// Showing reminder details in an alertview

		let alertController = UIAlertController(title: notification.alertTitle, message: notification.alertBody, preferredStyle: .Alert)

		// self.window?.rootViewController?

		// presentViewController(alertController, animated: true, completion: nil)

		// UIAlertView(title: notification.alertTitle, message: notification.alertBody, delegate: nil, cancelButtonTitle: "OK").show()

		let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
			UIAlertAction in
			NSLog("OK Pressed")
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
			UIAlertAction in
			NSLog("Cancel Pressed")
		}

		alertController.addAction(okAction)
		alertController.addAction(cancelAction)
		self.window?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)

		print("Received Notification")
	}

	func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
		// Store the deviceToken in the current Installation and save it to Parse
		let installation = PFInstallation.currentInstallation()
		installation.setDeviceTokenFromData(deviceToken)
		installation.saveInBackground()
	}
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        if error.code == 3010 {
            print("Push notifications are not supported in the iOS Simulator.")
        } else {
            print("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
        }
    }
    
}

