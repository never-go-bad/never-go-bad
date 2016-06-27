//
//  MainTabViewController.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/20/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
class MainTabViewController: UIViewController {

    @IBOutlet weak var contentsView: UIView!
    
    @IBOutlet weak var buttonImage0: UIImageView!
    @IBOutlet weak var buttonView0: UIView!
    @IBOutlet weak var buttonText0: UILabel!
    
    @IBOutlet weak var buttonImage1: UIImageView!
    @IBOutlet weak var buttonText1: UILabel!
    @IBOutlet weak var buttonView1: UIView!
    
    @IBOutlet weak var buttonImage2: UIImageView!
    @IBOutlet weak var buttonView2: UIView!
    @IBOutlet weak var buttonText2: UILabel!
    
    
    var buttonViews: [UIView]! = []
    var buttonImages: [UIImageView]! = []
    var buttonTexts: [UILabel]! = []

    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tgr0 = UITapGestureRecognizer(target: self, action: #selector(MainTabViewController.onButtonTap(_:)))
        buttonView0.addGestureRecognizer(tgr0)
        buttonView0.tag = 0
        
        let tgr1 = UITapGestureRecognizer(target: self, action: #selector(MainTabViewController.onButtonTap(_:)))
        buttonView1.addGestureRecognizer(tgr1)
        buttonView1.tag = 1
        
        let tgr2 = UITapGestureRecognizer(target: self, action: #selector(MainTabViewController.onButtonTap(_:)))
        buttonView2.addGestureRecognizer(tgr2)
        buttonView2.tag = 2
        
        buttonViews.append(buttonView0)
        buttonViews.append(buttonView1)
        buttonViews.append(buttonView2)
        
        buttonTexts.append(buttonText0)
        buttonTexts.append(buttonText1)
        buttonTexts.append(buttonText2)
        
        buttonImages.append(buttonImage0)
        buttonImages.append(buttonImage1)
        buttonImages.append(buttonImage2)
        
        
        
        let vc1 = UIStoryboard(name: "FoodList", bundle: nil).instantiateViewControllerWithIdentifier("FoodListNavigationController") as! UINavigationController
        let vc2 = UIStoryboard(name: "RecipeSearch", bundle: nil).instantiateViewControllerWithIdentifier("RecipeSearchNavigationController") as! UINavigationController
        let vc3 = UIStoryboard(name: "Settings", bundle: nil).instantiateViewControllerWithIdentifier("SettingsNavigationController") as! UINavigationController
        
        viewControllers = [vc1, vc2, vc3]
        selectTap(0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onButtonTap(sender: UITapGestureRecognizer) {
        selectTap(sender.view!.tag)
    }
    
    func selectTap(index: Int) {
        let previousIndex = selectedIndex
        selectedIndex = index
        
        for i in 0..<3 {
            if i == selectedIndex {
                buttonImages[i].alpha = 1.0
                buttonTexts[i].alpha = 1.0
                buttonViews[i].backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.8)
            } else {
                buttonImages[i].alpha = 0.6
                buttonTexts[i].alpha = 0.6
                buttonViews[i].backgroundColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 0.8)
            }
        }
        
        
        let previousVC = viewControllers[previousIndex]
        previousVC.willMoveToParentViewController(nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
     
        let vc = viewControllers[selectedIndex]
        addChildViewController(vc)
        vc.view.frame = contentsView.bounds
        contentsView.addSubview(vc.view)
        vc.didMoveToParentViewController(self)
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
