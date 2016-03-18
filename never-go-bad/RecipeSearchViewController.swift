//
//  RecipeSearchViewController.swift
//  never-go-bad
//
//  Created by Andre Oriani on 3/12/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class RecipeSearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var dataSource: RecipeDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        
        searchBar.delegate = self
        
        dataSource = RecipeDataSource(forTable: tableView)
        //TODO: Change to use the about to expire food
        dataSource.searchFor("banana")

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
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let recipeDetailsVC = UIStoryboard(name: "RecipeDetails", bundle: nil).instantiateViewControllerWithIdentifier("recipeDetails") as! RecipeDetailsViewController
        recipeDetailsVC.recipeSummary = dataSource.getRecipeId(indexPath)
        self.navigationController?.pushViewController(recipeDetailsVC, animated: true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        dataSource.scrollViewDidScroll(scrollView)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
}
