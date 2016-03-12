//
//  RecipeService.swift
//  never-go-bad
//
//  Created by Andre Oriani on 3/12/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import Foundation
import AFNetworking
import ELCodable

class RecipeService {
    
    private static let baseUrl = "https://gentle-forest-65806.herokuapp.com"
    
    private let session = AFHTTPSessionManager(baseURL: NSURL(string: RecipeService.baseUrl)!)
    
    static let instance = RecipeService()
    
    func retrieveRecipe(withId epicuriousPath:String, onSuccess: (Recipe) -> Void, onError: () -> Void = {}) -> NetTask {
        return session.GET("recipe/" + epicuriousPath,
            parameters: nil,
            progress: nil,
            success: {
                (_, response) in
                do {
                    let json = JSON(response)
                    let recipe = try Recipe.decode(json)
                    onSuccess(recipe)
                } catch {
                    onError()
                }
            },
            failure: { _ in onError() }
        )
    }
    
    
    
    
}
