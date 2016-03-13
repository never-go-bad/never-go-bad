//
//  SettingsViewController.swift
//
//
//  Created by Kanch on 3/11/16.
//
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

	@IBOutlet weak var alertDaysPickerView: UIPickerView!

	@IBOutlet weak var alertTimePicker: UIDatePicker!

	var daysSelected: Int!
	var pickerDays = [1, 2, 3, 4, 5, 6, 7]

	let defaults = NSUserDefaults.standardUserDefaults()

	override func viewDidLoad() {
		super.viewDidLoad()

		alertDaysPickerView.delegate = self
		alertDaysPickerView.dataSource = self
		let index = pickerDays.indexOf(defaults.integerForKey("daysBeforeToFire")) ?? 0
		alertDaysPickerView.selectRow(index, inComponent: 0, animated: true)
		self.view.addSubview(alertDaysPickerView)
        
        alertTimePicker.date = defaults.objectForKey("timeToAlert") as! NSDate
        alertDaysPickerView.selectRow(index!, inComponent: 0, animated: true)
        
        
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}

	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return pickerDays.count
	}
	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return String(pickerDays[row])
	}

	func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
		return 36.0
	}

	func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
		return 36.0
	}

	func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

		defaults.setInteger(pickerDays[row], forKey: "daysBeforeToFire")
		defaults.synchronize()
	}

	@IBAction func onSaveButtonClicked(sender: AnyObject) {

		presentViewController(TabViewControllerHelper.createTabBarController(), animated: true, completion: nil)
	}

	@IBAction func timePickerComplete(sender: AnyObject) {
        
        var timer = sender as! UIDatePicker
        var selectedTimeHour = timer.date.hour()
        var selectedTimeMinute = timer.date.minute()
        
        defaults.setObject(timer.date, forKey: "timeToAlert")
		//alertTimePicker = UIDatePicker()
		//alertTimePicker.datePickerMode = UIDatePickerMode.Time
		//alertTimePicker.addTarget(self, action: Selector("handleTimePicker:"), forControlEvents: UIControlEvents.ValueChanged)
	}

	
}

/*
 // MARK: - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

