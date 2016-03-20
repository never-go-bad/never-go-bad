//
//  FoodList.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/2/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
let SECONDS_IN_DAYS = 86400
class FoodList: NSObject {
    static var foods: [Food]? = nil
    class func getCurrentFoods() -> [Food] {
        if foods == nil {
            let defaults = NSUserDefaults.standardUserDefaults()
            foods = defaults.objectForKey("food") as? [Food] ?? [Food]()
        }
        return foods!
    }
    
    class func saveCurrentFoods(foods: [Food]) {
        self.foods = foods
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(self.foods, forKey: "food")
        defaults.synchronize()
    }
    
    class func addFoodInputs(foodInputs: [FoodInput]) {
        for foodInput in foodInputs {

            let today = NSCalendar.currentCalendar().startOfDayForDate(NSDate())
            foods?.append(Food(
                name: foodInput.name,
                expireDate: today.dateByAddingTimeInterval(Double.init(foodInput.daysLeft * SECONDS_IN_DAYS)),
                photoUrl: foodInput.photoUrl,
                quantityType: foodInput.quantityType,
                quantity: foodInput.quantity))
        }
    }
}
