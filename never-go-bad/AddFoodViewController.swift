//
//  AddFoodViewController.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/2/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class AddFoodViewController: UIViewController,
    UITableViewDelegate, UITableViewDataSource,
    AddFoodTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    var foods = [
        Food(name: "name1", expireDate: NSDate(), quantityType: QuantityType.unit, quantity: 2),
        Food(name: "name2", expireDate: NSDate(), quantityType: QuantityType.unit, quantity: 10),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.setEditing(true, animated: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if indexPath.row < foods.count {
            return UITableViewCellEditingStyle.Delete
        } else {
            return UITableViewCellEditingStyle.Insert
        }
//        UITableViewCellEditingStyle.Insert
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        editingStyle
        if editingStyle == UITableViewCellEditingStyle.Insert {
            foods.append(Food(name: "", expireDate: NSDate(), quantityType: QuantityType.unit, quantity: 1))
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Bottom)
        } else if editingStyle == UITableViewCellEditingStyle.Delete {
            foods.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Bottom)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row < foods.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("AddFoodTableViewCell") as! AddFoodTableViewCell
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("ManuallyAddFoodTableViewCell")!
            return cell
        }
    }
    @IBAction func touchAddItemManually(sender: AnyObject) {
        foods.append(Food(name: "", expireDate: NSDate(), quantityType: QuantityType.unit, quantity: 1))
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: foods.count - 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Bottom)
    }

    func addFoodTableViewCell(addFoodTableViewCell: AddFoodTableViewCell, didCellValueChanged name: String) {
        let indexPath = tableView.indexPathForCell(addFoodTableViewCell)
        foods[indexPath!.row].name = name
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
