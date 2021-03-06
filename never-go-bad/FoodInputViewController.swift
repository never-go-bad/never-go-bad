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

let SECTION_FOOD_BUTTONS = 0
let SECTION_ADD_CELL = 1
let SECTION_FOOD_INPUTS = 2

class FoodInputViewController: UIViewController,
UITableViewDelegate, UITableViewDataSource,
BarcodeDelegate,
FoodSearchViewControllerDeletage,
UIImagePickerControllerDelegate, UINavigationControllerDelegate,
CloudSightQueryDelegate,
FoodInputButtonsTableViewCellDelegate
{
	@IBOutlet var topView: UIView!
	@IBOutlet weak var tableView: UITableView!

	// var daysBeforeToFire: Int = 3
	var foodInputs: [FoodInput] = []
	private var query: CloudSightQuery? // Must be declared here to ensure that the reference will stay live while query is being performed
	private var progressDialog: MBProgressHUD?

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
		tableView.estimatedRowHeight = 100
		tableView.rowHeight = UITableViewAutomaticDimension

		// André's keys
		CloudSightConnection.sharedInstance().consumerKey = "zyLoq-b0FIdsivIIm8MtHg"
		CloudSightConnection.sharedInstance().consumerSecret = "aH4RFQLr5gqfcOQuKxtNhA"
	}
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FoodInputViewController.keyboardDidShow(_:)),
            name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FoodInputViewController.keyboardDidHide(_:)),
            name: UIKeyboardDidHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidHideNotification, object: nil)
    }
    
    func keyboardDidShow(sender: NSNotification) {
        let info: NSDictionary = sender.userInfo!
        let value: NSValue = info.valueForKey(UIKeyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardSize: CGSize = value.CGRectValue().size
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }
    
    func keyboardDidHide(sender: NSNotification) {
        let contentInsets: UIEdgeInsets = UIEdgeInsetsZero
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == SECTION_ADD_CELL {
            return 1
        } else if section == SECTION_FOOD_INPUTS{
            return foodInputs.count
        } else {
            return 1
        }
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == SECTION_ADD_CELL {
            let cell = tableView.dequeueReusableCellWithIdentifier("ManuallyAddFoodTableViewCell")!
            return cell
        } else if indexPath.section == SECTION_FOOD_INPUTS {
            let cell = tableView.dequeueReusableCellWithIdentifier("FoodInputTableViewCell") as! FoodInputTableViewCell
            cell.foodInput = foodInputs[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("FoodInputButtonsTableViewCell") as! FoodInputButtonsTableViewCell
            cell.delegate = self
            return cell
        }
	}

    func prependFood(foodName: String, shelfLife: Int, photoUrl: String?, selected: Bool) {
        foodInputs.insert(FoodInput(name: foodName, daysLeft: shelfLife, photoUrl: photoUrl, selected: selected, quantityType: QuantityType.unit, quantity: 1), atIndex: 0)
		tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: SECTION_FOOD_INPUTS)], withRowAnimation: UITableViewRowAnimation.Bottom)
	}
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == SECTION_ADD_CELL {
            pushFoodSearchViewController()
        }
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
		for input in foodInputs {
            if input.selected {
                let food = input.toFood()
                foods.append(food)
                NotificationService.registerForExpiryAlert(food,
                    daysBeforeToFire: SettingsService.getDaysBeforeToAlert(),
                    timeToFire: SettingsService.getTimeToAlert())
            }
		}

		FoodService.save(foods)
		tableView.reloadData()

		self.navigationController?.popViewControllerAnimated(true)
	}

    func foodInputButtonsTableViewCell(barcodeButtonDidTap sender: FoodInputButtonsTableViewCell) {
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
                let photoUrl = barcodeResult.response.data[0].image_urls?[0]
                self.prependFood(foodName, shelfLife: 1, photoUrl: photoUrl, selected: true)
			}
			progress.hide(true)
		}

		BarcodeService.sharedInstance.getByUPC(barcode, onSuccess: productFoundClosure, onError: { progress.hide(true)})
	}

    func foodInputButtonsTableViewCell(cameraButtonDidTap sender: FoodInputButtonsTableViewCell) {
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
			picker.dismissViewControllerAnimated(true, completion: nil)
	}

	func sendToCloudSight(image: UIImage) {
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
                    self.prependFood(food.name, shelfLife: food.shelfLife, photoUrl: food.photoUrl, selected: false)
				}
			} else {
				self.showNonIdentifiedFoodDialog()
			}
		}
	}

    func foodSearchViewController(sender: FoodSearchViewController, didSelectFoodSearchResult foodName: String, shelfLife: Int, photoUrl: String?) {
		self.navigationController?.popViewControllerAnimated(true)
        prependFood(foodName, shelfLife: shelfLife, photoUrl: photoUrl, selected: true)
	}

	func showNonIdentifiedFoodDialog() {
		let alertDialog = UIAlertView(title: "Sorry!",
			message: "We could not identify any food.",
			delegate: nil,
			cancelButtonTitle: "OK")
		alertDialog.show()
	}
}
