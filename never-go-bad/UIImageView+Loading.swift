//
//  UIImageView+Loading.swift
//  Yelp
//
//  Created by Andre Oriani on 2/12/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation
import UIKit
import AFNetworking

extension UIImageView {
    func setLowHighResolutionImageWithUrl(lowRes lowResUrl: NSURL, highRes highResUrl:NSURL) {
        let lowResRequest = NSURLRequest(URL: lowResUrl)
        let highResRequest = NSURLRequest(URL: highResUrl)
        
        self.setImageWithURLRequest(lowResRequest,
            placeholderImage: nil,
            success: { (smallImageRequest, smallImageResponse, smallImage) -> Void in
                self.alpha = 0.0
                self.image = smallImage;
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    
                    self.alpha = 1.0
                    
                    }, completion: { (sucess) -> Void in
                        self.setImageWithURLRequest(
                            highResRequest,
                            placeholderImage: smallImage,
                            success: { (largeImageRequest, largeImageResponse, largeImage) -> Void in
                                
                                self.image = largeImage;
                                
                            },
                            failure: nil)
                })
                
            },
            failure: nil)
    }
    
    func fadedSetImageWithUrl(imageUrl:NSURL, placeholder:UIImage? = nil) {
        self.setImageWithURLRequest(NSURLRequest(URL: imageUrl),
            placeholderImage: placeholder, success: {
                (imageRequest, imageResponse, image) -> Void in
                if imageResponse != nil {
                    self.alpha = 0.0
                    self.image = image
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.alpha = 1.0
                    })
                } else {
                    self.image = image
                }
            },
            failure: nil)
    }
}

func addShadow(toView view:UIView) {
    view.layer.shadowOffset = CGSizeMake(1, 1)
    view.layer.shadowColor = UIColor.blackColor().CGColor
    view.layer.shadowRadius = 8.0
    view.layer.shadowOpacity = 0.80
    view.layer.shadowPath = UIBezierPath(rect: view.layer.bounds).CGPath
}

