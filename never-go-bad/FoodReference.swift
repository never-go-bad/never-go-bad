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
}
