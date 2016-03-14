//
//  RecipeDetailsViewController.swift
//  never-go-bad
//
//  Created by Andre Oriani on 3/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
    
    var recipeId: String!

    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeBgImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var willDoAgainLabel: UILabel!
    @IBOutlet weak var servingsTimeText: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RecipeService.instance.retrieveRecipe(withId: recipeId,
            onSuccess: {
                //TODO: Add some progress , which will be dismissed here
                recipe in self.populate(recipe)
                
            },
            onError: {
            
            //TODO:Show some error dialog
            self.navigationController?.popViewControllerAnimated(true)
        })
    }
    
    func populate(recipe: Recipe) {
        if recipe.image != nil {
            recipeBgImageView.fadedSetImageWithUrl(NSURL(string: recipe.image!)!)
        }
        
        recipeLabel.text = recipe.name
        willDoAgainLabel.text = recipe.wouldPrepareAgain
        let formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        formatter.minimumIntegerDigits = 1
        ratingLabel.text = formatter.stringFromNumber(recipe.rating.value)
        
        servingsTimeText.attributedText = decodeString("<b> Teste</b> : testeado")!
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