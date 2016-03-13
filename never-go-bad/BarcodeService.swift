//
//  BarcodeService.swift
//  APItests
//
//  Created by Andre Oriani on 3/1/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation
import BDBOAuth1Manager
import ELCodable

typealias NetTask = NSURLSessionDataTask!

class BarcodeService {
    private let session = SessionManager()
    
    static let sharedInstance = BarcodeService()
    
    private class SessionManager: BDBOAuth1SessionManager {
        let consumerKey = "w4u8Bq87NzbCCYOdMvCjYzetKrvQDiaXPFVKmG5R"
        let consumerSecret = "dci5dQqHK8FXOtkh0Y5Su1vXOT7K4gu4qiwQ6qyh"
        let baseUrl = NSURL(string: "http://api.v3.factual.com")
        
        private init() {
            super.init(baseURL: baseUrl, consumerKey: consumerKey, consumerSecret: consumerSecret)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override init(baseURL url: NSURL?, sessionConfiguration configuration: NSURLSessionConfiguration?) {
            super.init(baseURL: url, sessionConfiguration: configuration)
        }
    }
    
    
    func getByUPC(upc:String, onSuccess: (BarcodeResult)->Void, onError:()->Void) -> NetTask {
        return session.GET("t/products-cpg-nutrition",
            parameters: ["filters": "{\"upc\":\"\(upc)\"}"],
            success: {
                (_, response) -> Void in
                do {
                    let json = JSON(response)
                    let result = try BarcodeResult.decode(json)
                    onSuccess(result)
                } catch {
                    onError()
                }
            }, failure: {
                (_, _) -> Void in
                onError()
        })
    }


}
