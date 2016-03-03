//
//  AddFoodTableViewCell.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/2/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

@objc protocol AddFoodTableViewCellDelegate {
    func addFoodTableViewCell(addFoodTableViewCell: AddFoodTableViewCell, didCellValueChanged name: String)
}

var DAYS_LEFT_PICKER_VIEW = 1
var TYPE_PICKER_VIEW = 2
class AddFoodTableViewCell: UITableViewCell,
UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    var daysLeftPickerStrings = ["1 day", "2 days", "3 days", "4 days", "5 days", "6 days", "1 week", "2 weeks", "3 weeks", "1 month", "2 months"]
    var daysLeftPickerValues = [1, 2, 3, 4, 5, 6, 7, 14, 21, 30, 60]
    
    var typePickerStrings = ["unit", "lb", "fl oz"]
    var typePickerValues = [QuantityType.unit, QuantityType.weight, QuantityType.volume]
    
    weak var delegate: AddFoodTableViewCellDelegate?
    @IBOutlet weak var foodNameLabel: UITextField!
    @IBOutlet weak var daysLeftLabel: UITextField!
    
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let daysLeftPickerView = UIPickerView()
        daysLeftLabel.inputView = daysLeftPickerView
        daysLeftLabel.delegate = self
        daysLeftPickerView.dataSource = self
        daysLeftPickerView.delegate = self
        daysLeftPickerView.tag = DAYS_LEFT_PICKER_VIEW
        
        let typePickerView = UIPickerView()
        typeTextField.inputView = typePickerView
        typeTextField.delegate = self
        typePickerView.dataSource = self
        typePickerView.delegate = self
        typePickerView.tag = TYPE_PICKER_VIEW
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func foodLabelEditingDidEnd(sender: AnyObject) {
        delegate?.addFoodTableViewCell(self, didCellValueChanged: foodNameLabel.text!)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == DAYS_LEFT_PICKER_VIEW {
            return daysLeftPickerStrings.count
        } else {
            return typePickerStrings.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == DAYS_LEFT_PICKER_VIEW {
            return daysLeftPickerStrings[row]
        } else {
            return typePickerStrings[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == DAYS_LEFT_PICKER_VIEW {
            daysLeftLabel.text = daysLeftPickerStrings[row]
        } else {
            typeTextField.text = typePickerStrings[row]
        }
    }
 
    
    // preventing user from editing directly
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return false
    }

}
