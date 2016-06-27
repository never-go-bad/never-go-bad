//
//  Checkbox.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/21/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

@objc protocol CheckboxDelegate {
    func checkbox(sender: Checkbox, didValueChange value: Bool)
}

class Checkbox: UIButton {

    // set these images!
    var checkedImage: UIImage?
    var uncheckedImage: UIImage?
    var delegate: CheckboxDelegate?
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, forState: .Normal)
            } else {
                self.setImage(uncheckedImage, forState: .Normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(Checkbox.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.isChecked = false
    }
    
    func buttonClicked(sender: UIButton) {
        if sender == self {
            if isChecked == true {
                isChecked = false
            } else {
                isChecked = true
            }
        }
        delegate?.checkbox(self, didValueChange: isChecked)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
