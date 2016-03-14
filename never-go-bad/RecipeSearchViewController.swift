//
//  RecipeSearchViewController.swift
//  never-go-bad
//
//  Created by Andre Oriani on 3/12/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class RecipeSearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var dataSource: RecipeDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableViewAutomaticDimension
        
        searchBar.delegate = self
        
        dataSource = RecipeDataSource(forTable: tableView)
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
    

}
