//
//  RecipeDataSource.swift
//  never-go-bad
//
//  Created by Andre Oriani on 3/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import Foundation
import UIKit

class RecipeDataSource: NSObject, UITableViewDataSource {
    
    private var items: [RecipeSearchResult.Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var tableView: UITableView
    private var currentSearchTask: NetTask?
    
    init(forTable tableView:UITableView) {
        self.tableView = tableView
        super.init()
        tableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: No results case
        return items.count
    }
    
    func searchFor(terms: String) {
        if currentSearchTask != nil {
            currentSearchTask!.cancel()
        }
        
        currentSearchTask = RecipeService.instance.searchRecipe(
            terms, page: 1,
            dietaryRestrictions: [],
            onSuccess: {
                result in self.items = result.recipes
                self.currentSearchTask = nil
            },
            onError: {
                self.items = []
                self.currentSearchTask = nil
            }
        )
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //TODO: No results case
        let cell  = tableView.dequeueReusableCellWithIdentifier(RecipeResultCell.id) as! RecipeResultCell
        cell.apply(items[indexPath.row])
        return cell
    }
    
    
}
