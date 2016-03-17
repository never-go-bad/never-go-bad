//
//  RecipeDetailsViewController.swift
//  never-go-bad
//
//  Created by Andre Oriani on 3/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
    
    var recipeSummary: RecipeSearchResult.Recipe!
    var lowResImage: String?
    
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeBgImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var willDoAgainLabel: UILabel!
    @IBOutlet weak var servingsTimeText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTranslucentNavBar()
        
        recipeLabel.text = recipeSummary.name
        ratingLabel.text = recipeSummary.rating != nil ? formatRating(recipeSummary.rating!.value) : "0.0"
        if let lowResImage = recipeSummary.image {
            recipeBgImageView.fadedSetImageWithUrl(NSURL(string: lowResImage)!)
        }

        
        RecipeService.instance.retrieveRecipe(withId: recipeSummary.id,
            onSuccess: {
                //TODO: Add some progress , which will be dismissed here
                recipe in self.populate(recipe)
                
            },
            onError: {
            
            //TODO:Show some error dialog
            self.navigationController?.popViewControllerAnimated(true)
        })
    }
    
    func setTranslucentNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.blackColor()
        shadow.shadowOffset = CGSize(width: 1, height: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSShadowAttributeName: shadow]
        
        
        
        let barShadow: NSShadow = NSShadow()
        barShadow.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        barShadow.shadowOffset = CGSize(width: 0, height: 1)
        
        let navBarTitleTextAttributes = [
            NSForegroundColorAttributeName: UIColor(red: 255, green: 255, blue: 255, alpha: 1),
            NSShadowAttributeName: barShadow
        ]
        self.navigationItem.backBarButtonItem?.setTitleTextAttributes(navBarTitleTextAttributes, forState: .Normal)
    }
    
    func populate(recipe: Recipe) {
        if recipe.image != nil {
            recipeBgImageView.setImageWithURL(NSURL(string: recipe.image!)!)
        }
        
        recipeLabel.text = recipe.name
        willDoAgainLabel.text = recipe.wouldPrepareAgain
        let formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        formatter.minimumIntegerDigits = 1
        ratingLabel.text = formatRating(recipe.rating.value)
        
        servingsTimeText.attributedText = decodeString(recipe.html)!
    }
  
    func formatRating(value: NSDecimalNumber) -> String {
        let formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        formatter.minimumIntegerDigits = 1
        return formatter.stringFromNumber(value)!
    }
    
    func decodeString(encodedString:String) -> NSAttributedString?
    {
        let encodedData = encodedString.dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            return try NSAttributedString(data: encodedData, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
}
