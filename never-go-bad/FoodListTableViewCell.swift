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
                let daysLeft = food.daysLeft()
                if daysLeft <= 0 {
                    daysLeftLabel.text = "Expired"
                } else if daysLeft == 1 {
                    daysLeftLabel.text = "Today"
                } else if daysLeft < 7 {
                    daysLeftLabel.text = "\(daysLeft) days"
                } else if daysLeft < 30 {
                    daysLeftLabel.text = "\(daysLeft/7) weeks"
                } else {
                    daysLeftLabel.text = "\(daysLeft/30) months"
                }
                
                if daysLeft < 7 {
                    daysLeftLabel.hidden = true
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
