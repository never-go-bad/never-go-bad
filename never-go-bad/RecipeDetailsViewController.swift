//
//  RecipeDetailsViewController.swift
//  never-go-bad
//
//  Created by Andre Oriani on 3/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import HCSStarRatingView
import HMSegmentedControl

class RecipeDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    var recipeSummary: RecipeSearchResult.Recipe!
    var lowResImage: String?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleBg: UIView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeBgImageView: UIImageView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var ratingView: HCSStarRatingView!
    @IBOutlet weak var wouldDoAgainLabe: UILabel!
    @IBOutlet weak var servingsDesc: UITextView!
    @IBOutlet weak var segmentContainer: UIView!
    @IBOutlet weak var recipeContentView: UIView!
    
    private var ingredients:NSAttributedString!
    private var steps:NSAttributedString!
    
    @IBOutlet weak var contentText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTranslucentNavBar()
        
        scrollView.delegate = self
        
        recipeLabel.text = recipeSummary.name
//        ratingLabel.text = recipeSummary.rating != nil ? formatRating(recipeSummary.rating!.value) : "0.0"
        if let lowResImage = recipeSummary.image {
            recipeBgImageView.fadedSetImageWithUrl(NSURL(string: lowResImage)!)
        } else {
            recipeBgImageView.image = UIImage(named: "genericFood")
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
        self.navigationController?.navigationBar.setBackgroundImage(imageFromColor(UIColor(red: 0.62, green: 0.02, blue: 0.11, alpha: 0.4)), forBarMetrics: .Default)
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func populate(recipe: Recipe) {
        if recipe.image != nil {
            recipeBgImageView.setImageWithURL(NSURL(string: recipe.image!)!)
        }
        
//        recipeLabel.text = recipe.name
//        willDoAgainLabel.text = recipe.wouldPrepareAgain
//        let formatter = NSNumberFormatter()
//        formatter.maximumFractionDigits = 1
//        formatter.minimumFractionDigits = 1
//        formatter.minimumIntegerDigits = 1
//        ratingLabel.text = formatRating(recipe.rating.value)
//        
//        servingsTimeText.attributedText = decodeString(recipe.html)!
        
        ratingView.value = CGFloat(recipe.rating.value.doubleValue)
        wouldDoAgainLabe.text = "\(recipe.wouldPrepareAgain) WOULD MAKE IT AGAIN"
        servingsDesc.attributedText = decodeString(recipe.servingsHtml)!
        
        
        let segmentedControl = HMSegmentedControl(sectionTitles: ["INGREDIENTS", "PROCEDURES"])
        segmentedControl.frame = CGRectMake(0, 0, segmentContainer.bounds.width, segmentContainer.bounds.height)
        segmentedControl.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.8)
        segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleBox
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown
        segmentedControl.selectionIndicatorColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.8)
        segmentedControl.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        segmentContainer.addSubview(segmentedControl)
        
        steps = decodeString(recipe.stepsHtml)
        ingredients = decodeString(recipe.ingredientsHtml)
        contentText.attributedText = ingredients
        segmentedControl.indexChangeBlock = {
                index in
            UIView.animateWithDuration(0.3,
                animations: {
                   self.contentText.alpha = 0.0
                },
                completion: {
                    _ in
                    self.contentText.attributedText = [self.ingredients, self.steps][index]
                    UIView.animateWithDuration(0.3,
                        animations: {
                            self.contentText.alpha = 1.0
                    })
            })
            
        }
        loadingView.hidden = true
        recipeContentView.hidden = false
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
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let fraction = min(scrollView.contentOffset.y/360.0, 1.0)
        self.navigationController?.navigationBar.setBackgroundImage(imageFromColor(UIColor(red: 0.62, green: 0.02, blue: 0.11, alpha: min(0.4 + fraction, 1.0))), forBarMetrics: .Default)
        
        print(scrollView.contentOffset.y)
        print(fraction)
    }
}
