//
//  FoodInput.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/3/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

// to be used when FoodInputTableView and related stuff
class FoodInput: NSObject {
    var name: String
    var daysLeft: Int
    var quantityType: QuantityType
    var quantity: Float
    
    init(name: String, daysLeft: Int, quantityType: QuantityType, quantity: Float) {
        self.name = name
        self.daysLeft = daysLeft
        self.quantityType = quantityType
        self.quantity = quantity
    }
    
    func expirationDate() -> NSDate {
        let today = NSCalendar.currentCalendar().startOfDayForDate(NSDate())
        let expirationDate = today.dateByAddingTimeInterval(Double(daysLeft))
        return expirationDate
    }
    
    func toFood() -> Food{
        return Food(name: self.name, expireDate: NSDate(), quantityType: self.quantityType, quantity: self.quantity)
    }
}
