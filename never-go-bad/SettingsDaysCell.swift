//
//  SettingsDaysCell.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/22/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class SettingsDaysCell: UITableViewCell {

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperValueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let daysBeforeToAlert = SettingsService.getDaysBeforeToAlert()
        stepper.value = Double(daysBeforeToAlert)
        stepper.wraps = false
        // stepper.autorepeat = true
        stepper.minimumValue = 1
        stepper.maximumValue = 7
        stepper.layer.cornerRadius = 5
        
        stepper.backgroundColor = UIColor(red: 0.62, green: 0.02, blue: 0.11, alpha:  1)
        
        stepperValueLabel.text = String(SettingsService.getDaysBeforeToAlert())
    }
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        stepperValueLabel.text = Int(sender.value).description
        SettingsService.setDaysBeforeToAlert(Int(sender.value))
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
