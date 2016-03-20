//
//  FoodListTableViewCell.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/2/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import SWTableViewCell

class FoodListTableViewCell: SWTableViewCell {

    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var daysLeftLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    
    var food: Food? {
        didSet {
            if let food = food {
                print(food.daysLeft(), food.expireDate)
                foodNameLabel.text = food.name
                var daysLeft = food.daysLeft()
                if daysLeft < 7 {
                    daysLeftLabel.hidden = true
                } else {
                    daysLeftLabel.hidden = false
                    var strs: [String] = []
                    if daysLeft > 30 {
                        strs.append("\(daysLeft / 30)m")
                        daysLeft -= daysLeft / 30 * 30
                    }
                    if daysLeft > 7 {
                        strs.append("\(daysLeft / 7)w")
                        daysLeft -= daysLeft / 7 * 7
                    }
                    if daysLeft > 0 {
                        strs.append("\(daysLeft)d")
                    }
                    daysLeftLabel.text = strs.joinWithSeparator(" ")
                }
                
                foodImageView.image = nil
                if let photoUrl = food.photoUrl {
                    foodImageView.setImageWithURL(NSURL(string: photoUrl)!)
                } else {
                    foodImageView.image = UIImage(named: "tree")
                }
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
