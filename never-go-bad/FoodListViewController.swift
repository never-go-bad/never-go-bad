//
//  FoodListViewController.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/2/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class FoodListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate {

    var foods: [Food]?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // foods = FoodList.getCurrentFoods()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        loadFood()
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadFood()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FoodListTableViewCell") as! FoodListTableViewCell
        cell.food = foods![indexPath.row]
        return cell
    }
    
    
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
//    {
//        let reuseIdentifier = "FoodListTableViewCell"
//        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! FoodListTableViewCell!
//        if cell == nil
//        {
//            cell = MGSwipeTableCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier) as! FoodListTableViewCell
//        }
//       cell.delegate = self //optional
//       cell.food = foods![indexPath.row]
//       
//        //configure left buttons
//        cell.leftButtons = [MGSwipeButton(title: "Delete",  backgroundColor: UIColor.redColor())]
//        cell.leftSwipeSettings.transition = MGSwipeTransition.Rotate3D
//        
//        //configure right buttons
//        cell.rightButtons = [MGSwipeButton(title: "Consumed", backgroundColor: UIColor.greenColor())
//            ,MGSwipeButton(title: "Trashed",backgroundColor: UIColor.lightGrayColor())]
//        cell.rightSwipeSettings.transition = MGSwipeTransition.Rotate3D
//        
//
//        return cell
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods?.count ?? 0

    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let consumed = UITableViewRowAction(style: .Normal, title: "Consumed") { action, index in
            self.foods?.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        consumed.backgroundColor = UIColor.greenColor()
        
        let trashed = UITableViewRowAction(style: .Normal, title: "Trashed") { action, index in
            self.foods?.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        trashed.backgroundColor = UIColor.lightGrayColor()
        
        let delete = UITableViewRowAction(style: .Normal, title: "Delete") { action, index in
            self.foods?.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        delete.backgroundColor = UIColor.redColor()
        
        return [consumed, trashed, delete]
        
        
        
    }
  
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    
    func loadFood() {
        FoodService.get { (foodItems) -> () in
            self.foods = foodItems
            self.tableView.reloadData()
        }
    }
    
    
//    func deleteFood(indexPath: NSIndexPath) {
//        FoodService.
//        
//    }
    
    func consumed(indexPath: NSIndexPath) {
        foods?.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
    }
    
    func trashed(indexPath: NSIndexPath) {
        foods?.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
