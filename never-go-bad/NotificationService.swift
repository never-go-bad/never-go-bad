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

    class func registerForExpiryAlert(foodItem: Food, daysBeforeToFire: Int, timeToFire: NSDate) -> Void {
        
        var fireDate = foodItem.expireDate.dateBySubtractingHours(daysBeforeToFire * 24 )
        print(foodItem.expireDate)
        print(fireDate)
        print(timeToFire.hour())
        print(timeToFire.minute())
        fireDate = fireDate.dateByAddingHours(timeToFire.hour())
        fireDate = fireDate.dateByAddingMinutes(timeToFire.minute())
        print(fireDate)
        //var dateComponents: NSDateComponents = NSDateComponents()
        
        // We want to alert 3 days before the expiration date
    //    let alertDate = foodItem.expireDate.dateByAddingTimeInterval(timeIntervalInSeconds) // Seconds for 3 days
        print("daysBeforeToFire \(daysBeforeToFire)")
        print("expireDate \(foodItem.expireDate)")
      //  print("alertDate \(alertDate)")
        let secondsFromNowToAlert = 5 //now.secondsBeforeDate(alertDate)
        
        print(secondsFromNowToAlert)
        
       // let secondsFromNowToAlert = now.secondsBeforeDate(alertDate)
        
        
//        let localNotif = UILocalNotification()
//		localNotif.alertTitle = "Food about to expire"
//		localNotif.alertBody = "Your \(foodItem.name) is about to expire"
//		localNotif.alertAction = "Report Consumption"
//		localNotif.hasAction = true
//        localNotif.fireDate = NSDate(timeInterval: 10, sinceDate:alertDate )//NSDate(timeIntervalSinceNow: NSTimeInterval(secondsFromNowToAlert))
//		localNotif.soundName = UILocalNotificationDefaultSoundName
//		UIApplication.sharedApplication().scheduleLocalNotification(localNotif)
       // self.navigationController?.popToRootViewControllerAnimated(true)
		//NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: nil, userInfo: nil, repeats: false)
        
        
        let localNotif = UILocalNotification()
        localNotif.alertTitle = "Food about to expire"
        localNotif.alertBody = "Your \(foodItem.name) is about to expire"
        localNotif.alertAction = "Report Consumption"
        localNotif.hasAction = true
        localNotif.fireDate = NSDate(timeInterval: 10, sinceDate:fireDate)//NSDate(timeIntervalSinceNow: NSTimeInterval(secondsFromNowToAlert))
        localNotif.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(localNotif)
    
	}
}