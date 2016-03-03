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

class AddFoodTableViewCell: UITableViewCell {

    weak var delegate: AddFoodTableViewCellDelegate?
    @IBOutlet weak var foodNameLabel: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func foodLabelEditingDidEnd(sender: AnyObject) {
        delegate?.addFoodTableViewCell(self, didCellValueChanged: foodNameLabel.text!)
    }

}
