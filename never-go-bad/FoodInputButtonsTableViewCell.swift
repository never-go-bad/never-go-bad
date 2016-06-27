//
//  FoodInputButtonsTableViewCell.swift
//  never-go-bad
//
//  Created by Ji Oh Yoo on 3/22/16.
//  Copyright © 2016 codepath. All rights reserved.
//

@objc protocol FoodInputButtonsTableViewCellDelegate {
    func foodInputButtonsTableViewCell(cameraButtonDidTap sender: FoodInputButtonsTableViewCell)
    func foodInputButtonsTableViewCell(barcodeButtonDidTap sender: FoodInputButtonsTableViewCell)
}

import UIKit

class FoodInputButtonsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cameraButton: UIImageView!
    @IBOutlet weak var barcodeButton: UIImageView!
    
    var delegate: FoodInputButtonsTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cameraButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FoodInputButtonsTableViewCell.cameraButtonTap(_:))))
        barcodeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FoodInputButtonsTableViewCell.barcodeButtonTap(_:))))
    }
    
    func cameraButtonTap(sender: UITapGestureRecognizer) {
        delegate?.foodInputButtonsTableViewCell(cameraButtonDidTap: self)
    }
    
    func barcodeButtonTap(sender: UITapGestureRecognizer) {
        delegate?.foodInputButtonsTableViewCell(barcodeButtonDidTap: self)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
