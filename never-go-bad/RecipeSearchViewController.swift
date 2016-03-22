//
//  RecipeSearchViewController.swift
//  never-go-bad
//
//  Created by Andre Oriani on 3/12/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class RecipeSearchViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UICollectionView!
    @IBOutlet weak var emptyView: UIView!
    private var dataSource: RecipeDataSource!
    var needToRefresh = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        searchBar.delegate = self
        
        dataSource = RecipeDataSource(forTable: tableView, withEmpty: emptyView)
        
        UIBarButtonItem.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).tintColor = UIColor.blackColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "foodListDidChange:", name: notificationFoodListDidChange, object: nil)
    }

    func searchAboutToExpireFood() {
        FoodService.get {
            foodList in
            let sortedFood = foodList.sort {
                return $0.expireDate.timeIntervalSinceReferenceDate < $1.expireDate.timeIntervalSinceReferenceDate
            }
            let count = min(sortedFood.count, 2)
            let foodSearchStr = sortedFood[0..<count].map{ (food) -> String in
                food.name
                }.joinWithSeparator(" ").trim()
            if foodSearchStr.isEmpty {
                self.searchBar.text = "banana"
            } else {
                self.searchBar.text = foodSearchStr
            }
            
            self.searchBarSearchButtonClicked(self.searchBar)
            
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let searchTermFull = searchBar.text {
            let searchTerm = searchTermFull.trim()
            if !searchTerm.isEmpty {
                dataSource.searchFor(searchTerm)
            }
        }
        searchBar.resignFirstResponder()
        tableView.setContentOffset(CGPointZero, animated: false)
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let recipeDetailsVC = UIStoryboard(name: "RecipeDetails", bundle: nil).instantiateViewControllerWithIdentifier("recipeDetails") as! RecipeDetailsViewController
        recipeDetailsVC.recipeSummary = dataSource.getRecipeId(indexPath)
        self.navigationController?.pushViewController(recipeDetailsVC, animated: true)

    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        dataSource.scrollViewDidScroll(scrollView)
    }
    
    func foodListDidChange(sender: NSNotification) {
        needToRefresh = true
    }
   
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = nil
        if needToRefresh {
            searchAboutToExpireFood()
        }
        needToRefresh = false
    }
}
