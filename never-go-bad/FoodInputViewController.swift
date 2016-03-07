//
//  AddFoodViewController.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/2/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

class FoodInputViewController: UIViewController,
    UITableViewDelegate, UITableViewDataSource, BarcodeDelegate {

    @IBOutlet var topView: UIView!
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
    
    func appendFood(foodName:String) {
        foodInputs.append(FoodInput(name: foodName, daysLeft: 1, quantityType: QuantityType.unit, quantity: 1))
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: foodInputs.count - 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Bottom)
    }
    
    @IBAction func touchAddItemManually(sender: AnyObject) {
        appendFood("")
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
    
    @IBAction func onDidTapBarcodeButton(sender: AnyObject) {
        let storyBoard = UIStoryboard(name: "BarcodeDetector", bundle: nil)
        let barcodePresenter = storyBoard.instantiateViewControllerWithIdentifier(BarcodeDetectorViewController.storyBoardId) as! BarcodeDetectorViewController
        barcodePresenter.delegate = self
        presentViewController(barcodePresenter, animated: true, completion: nil)
    }
    
    func onBarcodeDetected(barcode barcode: String) {
        let progress = MBProgressHUD.showHUDAddedTo(topView, animated: true)
        progress.labelText = "searching food..."
        progress.show(true)
        
        let productFoundClosure: (BarcodeResult) -> Void = {
            barcodeResult in
            if (!barcodeResult.response.data.isEmpty) {
                let foodName = barcodeResult.response.data[0].brand! + " " + barcodeResult.response.data[0].product_name!
                self.appendFood(foodName)
            }
            progress.hide(true)
        }
        
        BarcodeService.sharedInstance.getByUPC(barcode, onSuccess: productFoundClosure, onError: {progress.hide(true)})

    }
   
}
