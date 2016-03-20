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
    var photoUrl: String?
    var quantityType: QuantityType
    var quantity: Float
    
    let SECONDS_IN_A_DAY = 86400
    
    init(name: String, daysLeft: Int, photoUrl: String?, quantityType: QuantityType, quantity: Float) {
        self.name = name
        self.daysLeft = daysLeft
        self.photoUrl = photoUrl
        self.quantityType = quantityType
        self.quantity = quantity
    }
    
    func expirationDate() -> NSDate {
        let today = NSCalendar.currentCalendar().startOfDayForDate(NSDate())
        let expirationDate = today.dateByAddingTimeInterval(Double(daysLeft * SECONDS_IN_A_DAY))
        return expirationDate
    }
    
    func toFood() -> Food{
        return Food(name: self.name, expireDate: expirationDate(), photoUrl: self.photoUrl, quantityType: self.quantityType, quantity: self.quantity)
    }
}
