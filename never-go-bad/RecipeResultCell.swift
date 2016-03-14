//
//  RecipeResultCell.swift
//  never-go-bad
//
//  Created by Andre Oriani on 3/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import HCSStarRatingView

class RecipeResultCell: UITableViewCell {
    
    static let id = "recipe"
    static let defaultImageUrl = "http://www.epicurious.com/css/i/recipe-img-icon.png"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var ratingView: HCSStarRatingView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func apply(recipe: RecipeSearchResult.Recipe) {
        titleLabel.text = recipe.name
        recipeImageView.image = nil
        let recipeImageUrl = NSURL(string: recipe.image ?? RecipeResultCell.defaultImageUrl)
        
        recipeImageView.fadedSetImageWithUrl(recipeImageUrl ?? NSURL(string: RecipeResultCell.defaultImageUrl)!)
        if let rating = recipe.rating {
            ratingView.hidden = false
            ratingView.value = CGFloat(rating.value.doubleValue)
        } else {
            ratingView.hidden = true
        }
        
    }

}
