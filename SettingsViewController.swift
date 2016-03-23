//
//  SettingsViewController.swift
//
//
//  Created by Kanch on 3/11/16.
//
//

import UIKit

class SettingsViewController: UIViewController
//, UIPickerViewDataSource, UIPickerViewDelegate
, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet weak var tableView: UITableView!
	var pickerDays = [1, 2, 3, 4, 5, 6, 7]

	override func viewDidLoad() {
		super.viewDidLoad()

//		alertDaysPickerView.delegate = self
//		alertDaysPickerView.dataSource = self

		tableView.delegate = self
		tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return DieteryConsideration.dieteryConsiderations.count
        } else if section == 1{
            return 1
        } else {
            return 1
        }
	}

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 3
	}
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Dietary Considerations"
        } else if section == 1 {
            return "Alert Before (# of Days)"
        } else {
            return "Time to Receive Notifications"
        }
    }

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("DieteryConsiderationCell", forIndexPath: indexPath) as! DieteryConsiderationCell
            cell.dieteryConsideration = DieteryConsideration.dieteryConsiderations[indexPath.row]
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("SettingsDaysCell", forIndexPath: indexPath) as! SettingsDaysCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("SettingsTimePickerCell", forIndexPath: indexPath) as! SettingsTimePickerCell
            return cell
        }
	}
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let nav = self.navigationController?.navigationBar
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
}