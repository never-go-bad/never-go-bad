//
//  FoodListTableViewCell.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/2/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class FoodListTableViewCell: MGSwipeTableCell {

    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var daysLeftLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    var food: Food? {
        didSet {
            if let food = food {
                foodNameLabel.text = food.name
                let daysLeft = food.daysLeft()
                if daysLeft < 0 {
                    daysLeftLabel.text = "Expired"
                } else if daysLeft == 0 {
                    daysLeftLabel.text = "Today"
                } else if daysLeft < 7 {
                    daysLeftLabel.text = "\(daysLeft) days"
                } else if daysLeft < 30 {
                    daysLeftLabel.text = "\(daysLeft/7) weeks"
                } else {
                    daysLeftLabel.text = "\(daysLeft/30) months"
                }
                quantityLabel.text = "\(food.quantity) \(food.quantityType)"
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
