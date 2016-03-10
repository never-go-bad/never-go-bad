//
//  FoodService.swift
//  never-go-bad
//
//  Created by Kanch on 3/4/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import Foundation
import Parse

class FoodService {

	class func save(foodItems: [Food]) -> Bool
	{
		for item in foodItems {
			let foodItem = PFObject(className: "FoodItem")
			foodItem["objectId"] = item.objectId
			foodItem["name"] = item.name
			foodItem["expirationDate"] = item.expireDate
			foodItem["quantityType"] = String(item.quantityType)
			foodItem["quantity"] = item.quantity
			// foodItem["daysLeft"]

			foodItem.saveInBackgroundWithBlock { (successful, error) -> Void in
				if successful
				{
					print("saved")
				}
				else
				{
					print("Didnt save")
				}
			}
		}

		return true
	}

	class func delete(food: Food, completion: () -> ()) -> Void {
		let query = PFQuery(className: "FoodItem")
		query.getObjectInBackgroundWithId(food.objectId) { (object, error) -> Void in
			if error != nil {
				NSLog("No food items left to be deleted")
			} else {
				object!.deleteInBackground()
			}
		}
	}

	class func get(completion: (foods: [Food]) -> ()) -> Void {

		let query = PFQuery(className: "FoodItem")
		// query.whereKey("playerName", equalTo:"Sean Plott")
		query.findObjectsInBackgroundWithBlock {
			(objects: [PFObject]?, error: NSError?) -> Void in

			if error == nil {
				// The find succeeded.
				print("Successfully retrieved \(objects!.count) food items.")
				// Do something with the found objects
				if let objects = objects {

					var foodItems : [Food] = []

					for object in objects {
						print(object.objectId)
						// var quantityType : QuantityType = QuantityType.fromStringValue(object["quantityType"] as! String)
						let obj: String = object.objectId!// (object["objectId"] as? String)!
						let food : Food = Food(
							objectId: obj, //
							name: (object["name"] as? String)!,
							expireDate: (object["expirationDate"] as? NSDate)!,
							quantityType: QuantityType.unit,
							quantity: (object["quantity"] as? Float)!)

						foodItems.append(food)
					}

					completion(foods: foodItems)
				}
			} else {
				// Log details of the failure
				print("Error: \(error!) \(error!.userInfo)")
			}
		}
	}
}