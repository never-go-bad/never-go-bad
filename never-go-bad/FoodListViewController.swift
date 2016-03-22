//
//  FoodListViewController.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/2/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import SWTableViewCell

class FoodListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate {

	var foods: [[Food]]?
	@IBOutlet weak var tableView: UITableView!

	// var daysBeforeToFire: Int = 3

	override func viewDidLoad() {
		super.viewDidLoad()
		// foods = FoodList.getCurrentFoods()
		tableView.dataSource = self
		tableView.delegate = self
		tableView.estimatedRowHeight = 100
		tableView.rowHeight = UITableViewAutomaticDimension

		loadFood()
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		loadFood()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Expired!"
        } else if section == 1 {
            return "Expiring Today!"
        } else if section < 7 {
            return "\(section) Days Left"
        } else {
            return "More Than a Week"
        }
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let foods = foods {
            return foods[section].count > 0 ? UITableViewAutomaticDimension : 0
        } else {
            return 0
        }
    }
    
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let foods = foods {
            return foods[section].count
        } else {
            return 0
        }
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cellIdentifier: String = "FoodListTableViewCell"
		let cell: FoodListTableViewCell = (tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! FoodListTableViewCell)
		cell.delegate = self
		cell.leftUtilityButtons = self.getLeftUtilityButtonsToCell() as [AnyObject]
		cell.rightUtilityButtons = self.getRightUtilityButtonsToCell() as [AnyObject]

		cell.food = foods![indexPath.section][indexPath.row]
		return cell
	}

	func getLeftUtilityButtonsToCell() -> NSMutableArray {
		let leftutilityButtons: NSMutableArray = NSMutableArray()
		leftutilityButtons.sw_addUtilityButtonWithColor(UIColor.grayColor(), title: NSLocalizedString("Delete", comment: ""))
		return leftutilityButtons
	}

	func getRightUtilityButtonsToCell() -> NSMutableArray {
		let rightUtilityButtons: NSMutableArray = NSMutableArray()
        rightUtilityButtons.sw_addUtilityButtonWithColor(UIColor(red:0.494, green:0.827, blue:0.129, alpha:1.00), icon: UIImage(named: "Gone"))
        rightUtilityButtons.sw_addUtilityButtonWithColor(UIColor(red:0.996, green:0.220 ,blue:0.141, alpha:1.00), icon: UIImage(named: "Trash"))
		return rightUtilityButtons
	}

	func swipeableTableViewCell(cell: SWTableViewCell!, didTriggerLeftUtilityButtonWithIndex index: Int) {
		// Delete Clicked
		if index == 0 {
			let cellIndexPath: NSIndexPath = tableView.indexPathForCell(cell)!
			// foods?.removeAtIndex(cellIndexPath.row)
			// self.tableView.deleteRowsAtIndexPaths([cellIndexPath], withRowAnimation: .Automatic)
			deleteFood(cellIndexPath)
		}
	}
    
	func swipeableTableViewCell(cell: SWTableViewCell!, didTriggerRightUtilityButtonWithIndex index: Int) {
		if index == 0 {
			let cellIndexPath: NSIndexPath = tableView.indexPathForCell(cell)!
			let foodConsumed = foods?[cellIndexPath.section][cellIndexPath.row]
			foodConsumed?.consumed = true
			FoodService.setConsumed(foodConsumed!, completion: { () -> () in
				self.tableView.reloadData()
			})
			foods?[cellIndexPath.section].removeAtIndex(cellIndexPath.row)
			self.tableView.deleteRowsAtIndexPaths([cellIndexPath], withRowAnimation: .Automatic)
		} else if index == 1 {
			let cellIndexPath: NSIndexPath = tableView.indexPathForCell(cell)!
			let foodTrashed = foods?[cellIndexPath.section][cellIndexPath.row]
			foodTrashed?.consumed = true
			FoodService.setTrashed(foodTrashed!, completion: { () -> () in
				self.tableView.reloadData()
			})
            foods?[cellIndexPath.section].removeAtIndex(cellIndexPath.row)
			self.tableView.deleteRowsAtIndexPaths([cellIndexPath], withRowAnimation: .Automatic)
		}
	}

	func swipeableTableViewCellShouldHideUtilityButtonsOnSwipe(cell: SWTableViewCell!) -> Bool {
		return true
	}

	func loadFood() {
		FoodService.get { (foodItems) -> () in
            self.foods = [[Food]](count: 8, repeatedValue: [Food]())
            for food in foodItems {
                let daysLeft = food.daysLeft()
                if daysLeft <= 0 {
                    self.foods![0].append(food)
                } else if daysLeft <= 6 {
                    self.foods![daysLeft].append(food)
                } else {
                    self.foods![7].append(food)
                }
            }
			self.tableView.reloadData()
		}
	}

	func deleteFood(indexPath: NSIndexPath) {
		let foodToDelete = foods![indexPath.section][indexPath.row]

		FoodService.delete(foodToDelete, completion: { () -> () in
			self.tableView.reloadData()
		})

        foods?[indexPath.section].removeAtIndex(indexPath.row)
		tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
	}

	/*
	 // MARK: - Navigation

	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	 // Get the new view controller using segue.destinationViewController.
	 // Pass the selected object to the new view controller.
	 }
	 */
}
