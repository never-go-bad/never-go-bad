//
//  FoodSearchViewController.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/12/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

@objc protocol FoodSearchViewControllerDeletage {
    func foodSearchViewController(sender: FoodSearchViewController, didSelectFoodSearchResult foodName: String, shelfLife: Int, photoUrl: String?)
}

class FoodSearchViewController: UIViewController,
    UITableViewDelegate, UITableViewDataSource,
    UISearchBarDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    weak var delegate: FoodSearchViewControllerDeletage?
    
    var foodSearchResults: [FoodReference]?
    var foundExactMatch: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        searchBar.delegate = self
        searchBar.text = ""
        // Do any additional setup after loading the view.
        
        print(FoodDictionaryService.sharedInstance)
        searchBar.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:",
            name: UIKeyboardDidShowNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
    }
    
    func keyboardDidShow(sender: NSNotification) {
        let info: NSDictionary = sender.userInfo!
        let value: NSValue = info.valueForKey(UIKeyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardSize: CGSize = value.CGRectValue().size
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     food search logic:
     1) if user's trimmed input is an empty string, show "Search for food item" placeholder cell. In this case, foodSearchResults is set to nil.
     2) otherwise, search in the food dictionary and show the result.
     2-1) if the exact match was not found, append another cell to add the custom input
     */
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("search Text: " + searchText)
        
        if searchText.trim() == "" {
            foodSearchResults = nil
        } else {
            // do search, show fake results for now
            (foodSearchResults, foundExactMatch) = FoodDictionaryService.searchFoodItemWithPrefix(searchText)
        }
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let foodSearchResults = foodSearchResults {
            return foodSearchResults.count + 1
        } else { // user's trimmed input is an empty string.
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let foodSearchResults = foodSearchResults {
            if indexPath.row < foodSearchResults.count {
                let cell = tableView.dequeueReusableCellWithIdentifier("FoodSearchTableViewCell") as! FoodSearchTableViewCell
                cell.foodReference = foodSearchResults[indexPath.row]
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("FoodSearchManualTableViewCell") as! FoodSearchManualTableViewCell
                cell.foodNameLabel.text = "Add \(searchBar.text!) in my list"
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("FoodSearchTableViewCellPlaceholder")!
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let foodSearchResults = foodSearchResults {
            if indexPath.row < foodSearchResults.count {
                let ref = foodSearchResults[indexPath.row]
                delegate?.foodSearchViewController(self, didSelectFoodSearchResult: ref.name, shelfLife: ref.shelfLife, photoUrl: ref.photoUrl)
            } else {
                delegate?.foodSearchViewController(self, didSelectFoodSearchResult: searchBar.text!, shelfLife: 1, photoUrl: nil)
            }
        }
    }
}
