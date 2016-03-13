//
//  RecipeSearchViewController.swift
//  never-go-bad
//
//  Created by Andre Oriani on 3/12/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class RecipeSearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var dataSource: RecipeDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableViewAutomaticDimension
        
        dataSource = RecipeDataSource(forTable: tableView)
        dataSource.searchFor("banana")

    }


}
