//
//  RecipeResultCell.swift
//  never-go-bad
//
//  Created by Andre Oriani on 3/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import HCSStarRatingView

class RecipeResultCell: UICollectionViewCell {
    
    static let id = "recipe"
    static let defaultImageUrl = "http://www.epicurious.com/css/i/recipe-img-icon.png"


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var starsView: HCSStarRatingView!
    @IBOutlet weak var card: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        card.layer.shadowOffset = CGSizeMake(1, 1)
        card.layer.shadowColor = UIColor.blackColor().CGColor
        card.layer.shadowRadius = 2.0
        card.layer.shadowOpacity = 0.60
        card.layer.shadowPath = UIBezierPath(rect: card.layer.bounds).CGPath
        card.layer.cornerRadius = 2.0
        
    }

    
    func apply(recipe: RecipeSearchResult.Recipe) {
        titleLabel.text = recipe.name
        recipeImageView.image = nil
        let recipeImageUrl = NSURL(string: recipe.image ?? RecipeResultCell.defaultImageUrl)
        
        recipeImageView.fadedSetImageWithUrl(recipeImageUrl ?? NSURL(string: RecipeResultCell.defaultImageUrl)!)
        if let rating = recipe.rating {
            starsView.hidden = false
            starsView.value = CGFloat(rating.value.doubleValue)
        } else {
            starsView.hidden = true
        }
        
    }

}
