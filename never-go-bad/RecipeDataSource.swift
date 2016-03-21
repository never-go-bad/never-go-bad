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

class RecipeDataSource: NSObject, UICollectionViewDataSource {
    
    private var items: [RecipeSearchResult.Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var tableView: UICollectionView
    private var currentSearchTask: NetTask? = nil
    private var searchTerm = ""
    private var currentPage = 1
    private var currentProgressHub: MBProgressHUD?
    private var loadingMoreView:InfiniteScrollActivityView!
    private var emptyView: UIView
    
    init(forTable tableView:UICollectionView, withEmpty emptyView:UIView) {
        self.tableView = tableView
        self.emptyView = emptyView
        super.init()
        tableView.dataSource = self
        
        // Set up Infinite Scroll loading indicator
        let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView.hidden = true
        tableView.addSubview(loadingMoreView)
        
        var insets = tableView.contentInset;
        insets.bottom += InfiniteScrollActivityView.defaultHeight;
        tableView.contentInset = insets
    }
    
    
    func searchFor(terms: String) {
        if currentSearchTask != nil {
            currentSearchTask!.cancel()
            currentPage = 1
            currentProgressHub?.hide(false)
            currentProgressHub = nil
            
        }
        emptyView.hidden = true
        
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
                self.emptyView.hidden = (!self.items.isEmpty)
            },
            onError: {
                self.currentSearchTask = nil
                self.currentProgressHub?.hide(true)
                self.currentProgressHub = nil
                self.items = []
               self.emptyView.hidden = false
            }
        )
    }
    
    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Results for \"\(searchTerm)\""
//    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Don't show "no results" while searching
        //return items.isEmpty ? (currentProgressHub == nil ? 1 : 0) : items.count
        return items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if items.isEmpty {
            return tableView.dequeueReusableCellWithReuseIdentifier("noRecipes", forIndexPath: indexPath)
        } else {
            let cell  = tableView.dequeueReusableCellWithReuseIdentifier(RecipeResultCell.id, forIndexPath: indexPath) as! RecipeResultCell
            cell.apply(items[indexPath.row])
            return cell
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if currentSearchTask == nil  {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                // Code to load more results
                loadMoreData()
            }
        }
    }
    
    func loadMoreData() {
        currentPage++
        
        RecipeService.instance.searchRecipe(searchTerm,
            page: currentPage,
            dietaryRestrictions: [],
            onSuccess: {
                response in
                self.loadingMoreView!.stopAnimating()
                self.currentSearchTask = nil
                self.items.appendContentsOf(response.recipes)
            }, onError: {
                self.loadingMoreView!.stopAnimating()
                self.currentSearchTask = nil
        })
    }
    
    func getRecipeId(indexPath: NSIndexPath) -> RecipeSearchResult.Recipe {
        return items[indexPath.row]
    }
}
