//
//  Food.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/2/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class Food: NSObject {
    var name: String
    var expireDate: NSDate
    var quantityType: QuantityType
    var quantity: Float
    
    init(name: String, expireDate: NSDate, quantityType: QuantityType, quantity: Float) {
        self.name = name
        self.expireDate = expireDate
        self.quantityType = quantityType
        self.quantity = quantity
    }
    
    func daysLeft() -> Int {
        let today = NSCalendar.currentCalendar().startOfDayForDate(NSDate())
        let diff = Int(expireDate.timeIntervalSinceDate(today))
        return diff / SECONDS_IN_DAYS
    }
}

enum QuantityType: CustomStringConvertible {
    case unit
    case weight
    case volume

    var description : String {
        switch self {
        case .unit: return "units";
        case .weight: return "lbs";
        case .volume: return "fl oz";
        }
    }
}