//
//  RecipeListViewController.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/4/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

class RecipeListViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        loadRecipe()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    @IBAction func onRetryButton(sender: UIBarButtonItem) {
        loadRecipe()
    }
    
    func loadRecipe() {
        let foods = FoodList.getCurrentFoods().sort { (f1, f2) -> Bool in
            return f1.expireDate.timeIntervalSinceReferenceDate < f2.expireDate.timeIntervalSinceReferenceDate
        }
        let baseUrl = "http://www.epicurious.com/tools/searchresults?type=simple&search="
        let num = foods.count < 2 ? foods.count : 2
        let foodsStr = foods[0..<num].map { (food) -> String in
            food.name
            }.joinWithSeparator(" ").stringByReplacingOccurrencesOfString(" ", withString: "+")
        webView.loadRequest(NSURLRequest(URL: NSURL(string: baseUrl + foodsStr)!))
    }

    var loadingFrameCount = 0
    func webViewDidStartLoad(webView: UIWebView) {
        if loadingFrameCount == 0 {
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        }
        loadingFrameCount += 1
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        loadingFrameCount -= 1
        if loadingFrameCount == 0 {
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        }
    }
    
    
    func shuffleArray<Food>(var array: [Food]) -> [Food] {
        var ret: [Food] = []
        for index in 0..<array.count {
            ret.append(array[index])
        }
        for index in (0..<ret.count).reverse() {
            let randomIndex = Int(arc4random_uniform(UInt32(index)))
            (ret[index], ret[randomIndex]) = (ret[randomIndex], ret[index])
        }
        return ret
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
