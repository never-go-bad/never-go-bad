//
//  SettingsService.swift
//  never-go-bad
//
//  Created by Kanch on 3/12/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import Foundation

class SettingsService{

    static let defaults = NSUserDefaults.standardUserDefaults()
    
    class func getDaysBeforeToAlert() -> Int {
        
        var preference = defaults.integerForKey("daysBeforeToFire")
        
        //0 means user hasn't saved any preference. so default to 3 days.
        if(preference == 0) {
            preference = 3
        }
        
        return preference
    }
    
    class func setDaysBeforeToAlert(days: Int) -> Void {
        defaults.setInteger(days, forKey: "daysBeforeToFire")
        defaults.synchronize()
    }
    
    class func getTimeToAlert() -> NSDate {
        var preference = defaults.objectForKey("timeToAlert") as? NSDate
        
        //nil means user hasn't saved any preference. so default to 6:00PM
        if(preference == nil){
            preference = NSDate()
            preference!.dateByAddingHours(18)
        }
        
        return preference!
    }
    
    class func setTimeToAlert(time : NSDate){
        defaults.setObject(time, forKey: "timeToAlert")
    }
    
    class func getDieteryConsideration(dietType: DietaryConsiderationEnum) -> Bool {
        let considertion: Bool? = defaults.boolForKey(dietType.rawValue)
        return considertion ?? false
    }
    
    class func setDieteryConsideration(dietType: DietaryConsiderationEnum, value: Bool){
        defaults.setBool(value, forKey: dietType.rawValue)
    }
}