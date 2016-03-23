//
//  SettingsTimePickerCell.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/22/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class SettingsTimePickerCell: UITableViewCell {

    @IBOutlet weak var alertTimePicker: UIDatePicker!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        alertTimePicker.date = SettingsService.getTimeToAlert()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func timePickerComplete(sender: AnyObject) {
        let timer = sender as! UIDatePicker
        SettingsService.setTimeToAlert(timer.date)
    }    
}
