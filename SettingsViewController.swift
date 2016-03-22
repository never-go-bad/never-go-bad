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

	//@IBOutlet weak var alertDaysPickerView: UIPickerView!
	@IBOutlet weak var alertTimePicker: UIDatePicker!

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stepperValueLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	var pickerDays = [1, 2, 3, 4, 5, 6, 7]

	override func viewDidLoad() {
		super.viewDidLoad()

//		alertDaysPickerView.delegate = self
//		alertDaysPickerView.dataSource = self

		tableView.delegate = self
		tableView.dataSource = self
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
		let daysBeforeToAlert = SettingsService.getDaysBeforeToAlert()
        stepper.value = Double(daysBeforeToAlert)
        
		alertTimePicker.date = SettingsService.getTimeToAlert()
        
        stepper.wraps = false
       // stepper.autorepeat = true
        stepper.minimumValue = 1
        stepper.maximumValue = 7
        stepper.layer.cornerRadius = 5
        
        stepper.backgroundColor = UIColor(red: 0.62, green: 0.02, blue: 0.11, alpha:  1)
        
        stepperValueLabel.text = String(SettingsService.getDaysBeforeToAlert())
        
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
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
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var nav = self.navigationController?.navigationBar
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    @IBAction func stepperValueChanged(sender: UIStepper) {
        stepperValueLabel.text = Int(sender.value).description
        SettingsService.setDaysBeforeToAlert(Int(sender.value))
    
    }
}