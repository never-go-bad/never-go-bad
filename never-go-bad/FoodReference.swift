//
//  FoodReference.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/12/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class FoodReference: NSObject {
    var name: String
    var shelfLife: Int // days, from USDA database
    var photoUrl: String?
    
    init(name: String, shelfLife: Int, photoUrl: String?) {
        self.name = name
        self.shelfLife = shelfLife
        self.photoUrl = photoUrl
    }

    var shelfLifeString: String {
        get {
            if shelfLife == 1 {
                return "1 day"
            } else if shelfLife < 7 {
                return "\(shelfLife) days"
            } else if shelfLife == 7 {
                return "1 week"
            } else if shelfLife < 30 {
                return "\(shelfLife / 7) weeks"
            } else if shelfLife == 30 {
                return "1 month"
            } else {
                return "\(shelfLife / 30) months"
            }
        }
    }
}
