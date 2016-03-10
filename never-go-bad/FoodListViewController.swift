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

	var foods: [Food]?
	@IBOutlet weak var tableView: UITableView!

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

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return foods?.count ?? 0
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cellIdentifier: String = "FoodListTableViewCell"
		let cell: FoodListTableViewCell = (tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! FoodListTableViewCell)
		cell.delegate = self
		cell.leftUtilityButtons = self.getLeftUtilityButtonsToCell() as [AnyObject]
		cell.rightUtilityButtons = self.getRightUtilityButtonsToCell() as [AnyObject]

		cell.food = foods![indexPath.row]
		return cell
	}

	func getLeftUtilityButtonsToCell() -> NSMutableArray {
		let leftutilityButtons: NSMutableArray = NSMutableArray()
		leftutilityButtons.sw_addUtilityButtonWithColor(UIColor.redColor(), title: NSLocalizedString("Delete", comment: ""))
		return leftutilityButtons
	}

	func getRightUtilityButtonsToCell() -> NSMutableArray {
		let rightUtilityButtons: NSMutableArray = NSMutableArray()
		rightUtilityButtons.sw_addUtilityButtonWithColor(UIColor.greenColor(), title: NSLocalizedString("Consumed", comment: ""))
		rightUtilityButtons.sw_addUtilityButtonWithColor(UIColor.lightGrayColor(), title: NSLocalizedString("Trashed", comment: ""))
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
			foods?.removeAtIndex(cellIndexPath.row)
			self.tableView.deleteRowsAtIndexPaths([cellIndexPath], withRowAnimation: .Automatic)
			print("Consumed Clicked")
		} else if index == 1 {
			let cellIndexPath: NSIndexPath = tableView.indexPathForCell(cell)!
			foods?.removeAtIndex(cellIndexPath.row)
			self.tableView.deleteRowsAtIndexPaths([cellIndexPath], withRowAnimation: .Automatic)
			print("Trashed Clicked")
		}
	}

	func swipeableTableViewCellShouldHideUtilityButtonsOnSwipe(cell: SWTableViewCell!) -> Bool {
		return true
	}

	func loadFood() {
		FoodService.get { (foodItems) -> () in
			self.foods = foodItems
			self.tableView.reloadData()
		}
	}

	func deleteFood(indexPath: NSIndexPath) {
		let foodToDelete = foods![indexPath.row]

        FoodService.delete(foodToDelete, completion: { () -> () in
            self.tableView.reloadData()
        })

		foods?.removeAtIndex(indexPath.row)
		tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
	}

	func consumed(indexPath: NSIndexPath) {
		foods?.removeAtIndex(indexPath.row)
		tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
	}

	func trashed(indexPath: NSIndexPath) {
		foods?.removeAtIndex(indexPath.row)
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
