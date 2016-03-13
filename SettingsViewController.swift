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

	var pickerDays = [1, 2, 3, 4, 5, 6, 7]

	override func viewDidLoad() {
		super.viewDidLoad()

		alertDaysPickerView.delegate = self
		alertDaysPickerView.dataSource = self

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
		return String(pickerDays[row])
	}

	func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
		return 36.0
	}

	func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
		return 36.0
	}

	func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		SettingsService.setDaysBeforeToAlert(pickerDays[row])
	}

	@IBAction func onSaveButtonClicked(sender: AnyObject) {
		presentViewController(TabViewControllerHelper.createTabBarController(), animated: true, completion: nil)
	}

	@IBAction func timePickerComplete(sender: AnyObject) {
		let timer = sender as! UIDatePicker
		SettingsService.setTimeToAlert(timer.date)
	}
}