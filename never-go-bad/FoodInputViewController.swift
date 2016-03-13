//
//  AddFoodViewController.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/2/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD
import UIImage_Categories
import CloudSight

class FoodInputViewController: UIViewController,
    UITableViewDelegate, UITableViewDataSource,
    BarcodeDelegate,
    FoodSearchViewControllerDeletage,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate,
    CloudSightQueryDelegate

{
    
    let defaults = NSUserDefaults.standardUserDefaults()

    @IBOutlet var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
  //  var daysBeforeToFire: Int = 3
    var foodInputs: [FoodInput] = []
    private var query: CloudSightQuery? //Must be declared here to ensure that the reference will stay live while query is being performed
    private var progressDialog: MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.setEditing(true, animated: true)

        //André's keys
        CloudSightConnection.sharedInstance().consumerKey = "zyLoq-b0FIdsivIIm8MtHg"
        CloudSightConnection.sharedInstance().consumerSecret = "aH4RFQLr5gqfcOQuKxtNhA"
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
//            foodInputs.append(FoodInput(name: "", daysLeft: 1, quantityType: QuantityType.unit, quantity: 1))
//            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            //table + clicked
            pushFoodSearchViewController()

        
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
    
    func appendFood(foodName:String, shelfLife: Int) {
        foodInputs.append(FoodInput(name: foodName, daysLeft: shelfLife, quantityType: QuantityType.unit, quantity: 1))
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: foodInputs.count - 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Bottom)
    }
    
    @IBAction func touchAddItemManually(sender: AnyObject) {
//        appendFood("")
        // table + clicked
        pushFoodSearchViewController()
    }
    
    func pushFoodSearchViewController() {
        let storyBoard = UIStoryboard(name: "FoodSearch", bundle: nil)
        let vc = storyBoard.instantiateViewControllerWithIdentifier("FoodSearchViewController") as! FoodSearchViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func onConfirmButton(sender: UIBarButtonItem) {
        tableView.setEditing(false, animated: false)
        FoodList.addFoodInputs(foodInputs)
        
        var foods: [Food] = []
        for input in foodInputs{
            let food = input.toFood()
            foods.append(food)
            print(defaults.integerForKey("daysBeforeToFire"))
//            NotificationService.registerForExpiryAlert(food, daysBeforeToFire: defaults.integerForKey("daysBeforeToFire"), timeToFire: defaults.objectForKey("timeToAlert") as! NSDate)
        }
        
        FoodService.save(foods)
        tableView.reloadData()
        
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
                self.appendFood(foodName, shelfLife: 1)
            }
            progress.hide(true)
        }
        
        BarcodeService.sharedInstance.getByUPC(barcode, onSuccess: productFoundClosure, onError: {progress.hide(true)})

    }
   
    @IBAction func onDidTapCameraButton(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            let image = info[UIImagePickerControllerEditedImage] as! UIImage
            sendToCloudSight(image)
            picker.dismissViewControllerAnimated(true, completion:nil)
    }
    
    func sendToCloudSight(image:UIImage) {
        let resizedImage = image.resizedImageWithContentMode(.ScaleAspectFill, bounds: CGSizeMake(1024, 1024), interpolationQuality: .Default)
        let data = UIImageJPEGRepresentation(resizedImage, 0.7)
        query = CloudSightQuery(image: data, atLocation: CGPointMake(0.5, 0.5), withDelegate: self, atPlacemark: nil, withDeviceId: String(UIDevice.currentDevice().identifierForVendor))
        query?.start()
        progressDialog = MBProgressHUD.showHUDAddedTo(topView, animated: true)
        progressDialog!.labelText = "Please be patient..."
        progressDialog!.show(true)
    }
    
    func cloudSightQueryDidFail(query: CloudSightQuery!, withError error: NSError!) {
        dispatch_async(dispatch_get_main_queue()) {
            self.progressDialog?.hide(true)
            self.progressDialog = nil
            self.showNonIdentifiedFoodDialog()
        }
     }
    
    func cloudSightQueryDidFinishIdentifying(query: CloudSightQuery!) {
        dispatch_async(dispatch_get_main_queue()) {
            self.progressDialog?.hide(true)
            self.progressDialog = nil
            
            let matchedFoods = FoodDictionaryService.searchFoodItemWithDescription(query.title)
            if !matchedFoods.isEmpty {
                for food in matchedFoods {
                    self.appendFood(food.name, shelfLife: food.shelfLife)
                }
            } else {
                self.showNonIdentifiedFoodDialog()
            }

        }
        
        
    }
    
    func foodSearchViewController(sender: FoodSearchViewController, didSelectFoodSearchResult foodName: String, shelfLife: Int) {
        self.navigationController?.popViewControllerAnimated(true)
        appendFood(foodName, shelfLife: shelfLife)
    }

    func showNonIdentifiedFoodDialog() {
        let alertDialog = UIAlertView(title: "Sorry!",
            message: "We could not identify any food.",
            delegate: nil,
            cancelButtonTitle: "OK")
        alertDialog.show()
    }

}
