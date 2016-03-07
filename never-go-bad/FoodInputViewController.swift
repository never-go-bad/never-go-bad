//
//  AddFoodViewController.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/2/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class FoodInputViewController: UIViewController,
    UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var foodInputs: [FoodInput] = []
    
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
        if indexPath.row < foodInputs.count {
            return UITableViewCellEditingStyle.Delete
        } else {
            return UITableViewCellEditingStyle.Insert
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        editingStyle
        if editingStyle == UITableViewCellEditingStyle.Insert {
            foodInputs.append(FoodInput(name: "", daysLeft: 1, quantityType: QuantityType.unit, quantity: 1))
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        } else if editingStyle == UITableViewCellEditingStyle.Delete {
            foodInputs.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodInputs.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row < foodInputs.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("FoodInputTableViewCell") as! FoodInputTableViewCell
            cell.foodInput = foodInputs[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("ManuallyAddFoodTableViewCell")!
            return cell
        }
    }
    @IBAction func touchAddItemManually(sender: AnyObject) {
        foodInputs.append(FoodInput(name: "", daysLeft: 1, quantityType: QuantityType.unit, quantity: 1))
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: foodInputs.count - 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Bottom)
    }

    @IBAction func onConfirmButton(sender: UIBarButtonItem) {
        tableView.setEditing(false, animated: false)
        FoodList.addFoodInputs(foodInputs)
        
        var foods: [Food] = []
        for input in foodInputs{
            let food = input.toFood()
            foods.append(food)
            NotificationService.registerForExpiryAlert(food)
        }
        
        FoodService.save(foods)
        
        self.navigationController?.popViewControllerAnimated(true)
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
