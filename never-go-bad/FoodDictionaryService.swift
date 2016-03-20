//
//  FoodDictionaryService.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/12/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import CSwiftV
var foodDictionaryPath = "./../USDAShelfLife.csv"
class FoodDictionaryService {
    
    static let sharedInstance = FoodDictionaryService()
    
    var foodReferences: [FoodReference]
    
    init() {
        foodReferences = [FoodReference]()
        let path = NSBundle.mainBundle().pathForResource(foodDictionaryPath, ofType: nil)
        if let path = path {
            do {
                let text2 = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                let csv = CSwiftV.init(String: String(text2))
                print(csv)
                
                for line in csv.rows {
                    print(line)
                    let photoUrl: String? = line[2].trim().length == 0 ? nil : line[2].trim()
                    foodReferences.append(FoodReference(name: line[0], shelfLife: Int(line[1].trim())!, photoUrl: photoUrl))
                }
            }
            catch {/* error handling here */}
        } else {
            /* error handling here */
        }
    }
    
    class func searchFoodItemWithPrefix(searchText: String) -> (result: [FoodReference]?, foundExactMatch: Bool) {
        // to be used with food search view controller
        let trimmedSearchText = searchText.trim()
        var result = [FoodReference]()
        var foundExactMatch = false
        for ref in sharedInstance.foodReferences {
            if ref.name == trimmedSearchText {
                foundExactMatch = true
            }
            if ref.name.contains(trimmedSearchText) {
                result.append(ref)
            }
        }
        return (result, foundExactMatch)
    }
    
    class func searchFoodItemWithDescription(searchText: String) -> [FoodReference] {
        // to be used with food description with cloudsearch result
        var result = [FoodReference]()
        for ref in sharedInstance.foodReferences {
            for word in searchText.words() {
                if word.length >= 3 {
                    if ref.name.contains(word) {
                        result.append(ref)
                        break
                    }
                }
            }
        }
        return result
    }

}