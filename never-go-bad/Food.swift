//
//  Food.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/2/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class Food: NSObject {
    var objectId: String
    var name: String
    var expireDate: NSDate
    var quantityType: QuantityType
    var quantity: Float
    var consumed: Bool
    var trashed: Bool
    
    convenience init(objectId: String, name: String, expireDate: NSDate, quantityType: QuantityType, quantity: Float, consumed: Bool, trashed: Bool){
        self.init(name: name, expireDate: expireDate, quantityType: quantityType, quantity: quantity)
        self.objectId = objectId
        self.consumed = consumed
        self.trashed = trashed
    }

    
    init(name: String, expireDate: NSDate, quantityType: QuantityType, quantity: Float) {
        self.name = name
        self.expireDate = expireDate
        self.quantityType = quantityType
        self.quantity = quantity
        self.objectId = ""
        self.consumed = false
        self.trashed = false
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
    
    func fromStringValue(value: String) -> QuantityType {
        switch value {
        case "units": return .unit;
        case "lbs": return .weight;
        case "fl oz": return .volume;
        default: return .unit;
        }
    }
}