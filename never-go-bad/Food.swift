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
        let diff = Int(NSDate().timeIntervalSinceDate(expireDate))
        return diff / 3600
    }
}

enum QuantityType {
    case unit
    case weight
    case volume
}