//
//  SettingsViewController.swift
//
//
//  Created by Kanch on 3/11/16.
//
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet weak var alertDaysPickerView: UIPickerView!
	@IBOutlet weak var alertTimePicker: UIDatePicker!

	@IBOutlet weak var tableView: UITableView!
	var pickerDays = [1, 2, 3, 4, 5, 6, 7]

	override func viewDidLoad() {
		super.viewDidLoad()

		alertDaysPickerView.delegate = self
		alertDaysPickerView.dataSource = self

		tableView.delegate = self
		tableView.dataSource = self

        
		let daysBeforeToAlert = SettingsService.getDaysBeforeToAlert()
		let indexOfDaysBeforeToAlert = pickerDays.indexOf(daysBeforeToAlert)
		alertDaysPickerView.selectRow(indexOfDaysBeforeToAlert!, inComponent: 0, animated: true)
		self.view.addSubview(alertDaysPickerView)

		alertTimePicker.date = SettingsService.getTimeToAlert()
        
        
        
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}

	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return pickerDays.count
	}
	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return ("\(pickerDays[row]) Days")
	}

	func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		SettingsService.setDaysBeforeToAlert(pickerDays[row])
	}
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont(name: "Montserrat", size: 12)
            pickerLabel?.textColor = UIColor.blackColor()
            pickerLabel?.textAlignment = NSTextAlignment.Center
        }
        
        pickerLabel?.text = ("\(pickerDays[row]) Days")
        
        return pickerLabel!;
    }
    

	@IBAction func timePickerComplete(sender: AnyObject) {
		let timer = sender as! UIDatePicker
		SettingsService.setTimeToAlert(timer.date)
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return DieteryConsideration.dieteryConsiderations.count
	}

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCellWithIdentifier("DieteryConsiderationCell", forIndexPath: indexPath) as! DieteryConsiderationCell
		cell.dieteryConsideration = DieteryConsideration.dieteryConsiderations[indexPath.row]
		return cell
	}

	func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Dietery Consideration"
	}
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var nav = self.navigationController?.navigationBar
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
}