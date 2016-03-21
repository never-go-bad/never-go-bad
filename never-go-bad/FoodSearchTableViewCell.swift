//
//  FoodSearchTableViewCell.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/12/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class FoodSearchTableViewCell: UITableViewCell {
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var shelfLifeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var foodReference: FoodReference? {
        didSet {
            if let foodReference = foodReference {
                foodNameLabel.text = foodReference.name
                shelfLifeLabel.text = foodReference.shelfLifeString
            }
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
