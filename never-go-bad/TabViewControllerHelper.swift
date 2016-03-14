//
//  TabViewControllerHelper.swift
//  never-go-bad
//
//  Created by Kanch on 3/11/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import Foundation
import UIKit

class TabViewControllerHelper {

	class func createTabBarController() -> UITabBarController {

		let vc1 = UIStoryboard(name: "FoodList", bundle: nil).instantiateViewControllerWithIdentifier("FoodListNavigationController") as! UINavigationController
		let vc2 = UIStoryboard(name: "RecipeSearch", bundle: nil).instantiateViewControllerWithIdentifier("RecipeSearchNavigationController") as! UINavigationController
		let vc3 = UIStoryboard(name: "Settings", bundle: nil).instantiateViewControllerWithIdentifier("SettingsNavigationController") as! UINavigationController

		vc1.tabBarItem.title = "Inventory"
		vc1.tabBarItem.image = UIImage(named: "cart")

		vc2.tabBarItem.title = "Recipe"
		vc2.tabBarItem.image = UIImage(named: "equalizer")

		vc3.tabBarItem.title = "Settings"
		vc3.tabBarItem.image = UIImage(named: "gear")

		let tbc = UITabBarController()
		tbc.viewControllers = [vc1, vc2, vc3]
        
        print(NSURL(string: "http://assets.epicurious.com/photos/56325ba083f23b081c8f64c8/1:1/w_120%2Ch_120/2_ICBINB_Best ever_Banana_Bread_Carousel_Hi_Res.jpg"))
        
        return tbc
	}
}