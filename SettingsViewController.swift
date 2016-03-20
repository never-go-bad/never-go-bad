//
//  SettingsViewController.swift
//
//
//  Created by Kanch on 3/11/16.
//
//

import UIKit

@objc protocol SettingsViewControllerDelegate {
    optional func settingsViewController(settingsViewController: SettingsViewController, didDieteryRestrictionUpdate filters: [String:AnyObject])
}

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource, DieteryConsiderationCellDelegate {
    
    static let defaults = NSUserDefaults.standardUserDefaults()

	@IBOutlet weak var alertDaysPickerView: UIPickerView!
	@IBOutlet weak var alertTimePicker: UIDatePicker!

    @IBOutlet weak var tableView: UITableView!
	var pickerDays = [1, 2, 3, 4, 5, 6, 7]
    
    var switchStates = [Int:Bool]?()
    weak var delegate: SettingsViewControllerDelegate?

    
    let dieteryConsiderationDictionary: [[String: String]] =
    [["name" : "Healthy", "code" : "652"],
        ["name" : "Vegan", "code" : "656"],
        ["name" : "LowCholesterol", "code" : "655"],
        ["name" : "Kosher", "code" : "645"],
        ["name" : "Raw", "code" : "659"],
        ["name" : "KosherPesach", "code" : "658"]]
    

	override func viewDidLoad() {
		super.viewDidLoad()

		alertDaysPickerView.delegate = self
		alertDaysPickerView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
//        
//       tableView.estimatedRowHeight = 60
//        tableView.rowHeight = UITableViewAutomaticDimension
//
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
		return ("\(pickerDays[row]) Days" )
        
       // "expireDate \(foodItem.expireDate)"
	}

//	func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//		return 36.0
//	}
//
//	func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//		return 36.0
//	}

	func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		SettingsService.setDaysBeforeToAlert(pickerDays[row])
	}

	@IBAction func onSaveButtonClicked(sender: AnyObject) {
		presentViewController(TabViewControllerHelper.createTabBarController(), animated: true, completion: nil)
        var filters = [String : AnyObject] ()
        var selectedCategories = [String] ()
        if(switchStates != nil){
            for (row, isSelected) in switchStates!
            {
                selectedCategories.append(dieteryConsiderationDictionary[row]["code"]!)
            }
            if selectedCategories.count > 0
            {
                filters["categories"] = selectedCategories
            }
        }
        
        delegate?.settingsViewController!(self, didDieteryRestrictionUpdate: filters)
       // defaults.setValue(dieteryConsiderationDictionary, forKey: "dieteryConsideration")
	}

	@IBAction func timePickerComplete(sender: AnyObject) {
		let timer = sender as! UIDatePicker
		SettingsService.setTimeToAlert(timer.date)
	}
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section
//        {
//        case CaseCategory:
//            return categoriesDictionary.count
//        default:
//            return 1
//        }}
     return dieteryConsiderationDictionary.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DieteryConsiderationCell", forIndexPath: indexPath) as! DieteryConsiderationCell
        cell.dieteryConsiderationLabel.text = dieteryConsiderationDictionary[indexPath.row]["name"]
        cell.delegate = self
        //cell.onSwitch.on = switchStates![indexPath.row]!
        
        
        if(switchStates != nil) {
            cell.onSwitch.on = switchStates![indexPath.row] ?? false
        }
        else{
            cell.onSwitch.on  = false
        }
        
        //  cell.onSwitch.on  = switchStates![indexPath.row] ?? false
        
        print(cell.dieteryConsiderationLabel.text)
    
        return cell
    
}
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Dietery Consideration"
    }
    
//    @IBAction func dieteryConsiderationOnSave(sender: AnyObject) {
//        
//        dismissViewControllerAnimated(true, completion: nil)
//        var filters = [String : AnyObject] ()
//        var selectedCategories = [String] ()
//        if(switchStates != nil){
//            for (row, isSelected) in switchStates!
//            {
//                selectedCategories.append(dieteryConsiderationDictionary[row]["code"]!)
//            }
//            if selectedCategories.count > 0
//            {
//                filters["categories"] = selectedCategories
//            }
//        }
//        
//        delegate?.settingsViewController!(self, didDieteryRestrictionUpdate: filters)
//        
//    }
    
    func dieteryConsiderationCell(dieteryConsiderationCell: DieteryConsiderationCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPathForCell(dieteryConsiderationCell)!
        
        if(switchStates == nil) {
            switchStates = [Int:Bool]()
        }
        
        switchStates![indexPath.row] = value
        print ("filters view controller has the switch event")
    }

}