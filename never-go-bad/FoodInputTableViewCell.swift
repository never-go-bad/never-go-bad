//
//  AddFoodTableViewCell.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/2/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

var DAYS_LEFT_PICKER_VIEW = 1
class FoodInputTableViewCell: UITableViewCell,
UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    var daysLeftPickerStrings = ["1 day", "2 days", "3 days", "4 days", "5 days", "6 days", "1 week", "2 weeks", "3 weeks", "1 month", "2 months"]
    var daysLeftPickerValues = [1, 2, 3, 4, 5, 6, 7, 14, 21, 30, 60]
    
    var daysLeftPickerView: UIPickerView?
    
    @IBOutlet weak var foodNameTextField: UITextField!
    @IBOutlet weak var daysLeftTextField: UITextField!
    
    var foodInput: FoodInput? {
        didSet {
            if let foodInput = foodInput {
                foodNameTextField.text = foodInput.name
                
                if let idx = daysLeftPickerValues.indexOf(foodInput.daysLeft) {
                    daysLeftPickerView?.selectRow(idx, inComponent: 0, animated: false)
                    daysLeftTextField.text = daysLeftPickerStrings[idx]
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        daysLeftPickerView = UIPickerView()
        daysLeftTextField.inputView = daysLeftPickerView
        daysLeftTextField.delegate = self
        daysLeftPickerView!.dataSource = self
        daysLeftPickerView!.delegate = self
        daysLeftPickerView!.tag = DAYS_LEFT_PICKER_VIEW
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == DAYS_LEFT_PICKER_VIEW {
            return daysLeftPickerStrings.count
        } else {
            return -1
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == DAYS_LEFT_PICKER_VIEW {
            return daysLeftPickerStrings[row]
        } else {
            return nil
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == DAYS_LEFT_PICKER_VIEW {
            daysLeftTextField.text = daysLeftPickerStrings[row]
            foodInput?.daysLeft = daysLeftPickerValues[row]
        }
    }
    @IBAction func foodNameTextFieldChanged(sender: UITextField) {
        foodInput?.name = sender.text!
    }
 
    
    // preventing user from editing directly
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return false
    }

}
