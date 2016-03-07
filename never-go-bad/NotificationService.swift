//
//  NotificationService.swift
//  never-go-bad
//
//  Created by Kanch on 3/6/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import Foundation
import UIKit
import AFDateHelper

class NotificationService : NSObject {
    
    class func registerForNotifications(){
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
    }

    class func registerForExpiryAlert(foodItem: Food) -> Void {
       
        let now = NSDate()
        
        // We want to alert 3 days before the expiration date
        var alertDate = foodItem.expireDate.dateByAddingTimeInterval(NSTimeInterval(-259200)) // Seconds for 3 days
       
        let secondsFromNowToAlert =  now.secondsBeforeDate(alertDate)
       
        print(secondsFromNowToAlert)
        
       // let secondsFromNowToAlert = now.secondsBeforeDate(alertDate)
        
        
        let localNotif = UILocalNotification()
		localNotif.alertTitle = "Food about to expire"
		localNotif.alertBody = "Your \(foodItem.name) is about to expire"
		localNotif.alertAction = "Report Consumption"
		localNotif.hasAction = true
        localNotif.fireDate = NSDate(timeIntervalSinceNow: NSTimeInterval(secondsFromNowToAlert))
		localNotif.soundName = UILocalNotificationDefaultSoundName
		UIApplication.sharedApplication().scheduleLocalNotification(localNotif)
		NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: "timeout", userInfo: nil, repeats: false)
	}
    
    func timeout() {
        exit(10)
    }
    
}