//
//  RecipeDataSource.swift
//  never-go-bad
//
//  Created by Andre Oriani on 3/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class RecipeDataSource: NSObject, UITableViewDataSource {
    
    private var items: [RecipeSearchResult.Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var tableView: UITableView
    private var currentSearchTask: NetTask?
    private var searchTerm = ""
    private var currentPage = 1
    private var currentProgressHub: MBProgressHUD?
    
    init(forTable tableView:UITableView) {
        self.tableView = tableView
        super.init()
        tableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Don't show "no results" while searching
        return items.isEmpty ? (currentProgressHub == nil ? 1 : 0) : items.count
    }
    
    func searchFor(terms: String) {
        if currentSearchTask != nil {
            currentSearchTask!.cancel()
            currentPage = 1
            currentProgressHub?.hide(false)
            currentProgressHub = nil
        }
        
        searchTerm = terms
        //TODO: Stylize
        currentProgressHub = MBProgressHUD.showHUDAddedTo(tableView, animated: true)
        currentProgressHub?.labelText = "Search recipes..."
        currentSearchTask = RecipeService.instance.searchRecipe(
            terms, page: 1,
            dietaryRestrictions: [],
            onSuccess: {
                result in
                self.currentSearchTask = nil
                self.currentProgressHub?.hide(true)
                self.currentProgressHub = nil
                self.items = result.recipes
            },
            onError: {
                self.currentSearchTask = nil
                self.currentProgressHub?.hide(true)
                self.currentProgressHub = nil
                self.items = []
            }
        )
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if items.isEmpty {
            return tableView.dequeueReusableCellWithIdentifier("noRecipes")!
        } else {
            let cell  = tableView.dequeueReusableCellWithIdentifier(RecipeResultCell.id) as! RecipeResultCell
            cell.apply(items[indexPath.row])
            return cell
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Results for \"\(searchTerm)\""
    }
    
    
}
