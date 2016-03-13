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
    
    enum DietaryConsideration:String {
        case Healthy = "652", Vegan = "656", LowCholesterol = "655", Kosher = "645", Raw = "659", KosherPesach = "658"
    }
    
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
    
    func searchRecipe(searchTerm: String, page:Int = 1, dietaryRestrictions:[DietaryConsideration] = [], onSuccess: (RecipeSearchResult) -> Void, onError: () -> Void = {}) -> NetTask {
        
        //Not the correct level to make such decision, but let fix 20 recipes as the page size
        let pageSize = 20
        let pageOffset = (page - 1) * pageSize + 1
        
        var queryParams = ["search": searchTerm, "pageNumber": String(page), "pageSize": String(pageSize), "resultOffset" : String(pageOffset)]
        
        for restriction in dietaryRestrictions {
            queryParams["att"] = restriction.rawValue
        }
        
        return session.GET("recipes",
            parameters: queryParams,
            progress: nil,
            success: {
                (_, response) in
                do {
                    let json = JSON(response)
                    let recipes = try RecipeSearchResult.decode(json)
                    onSuccess(recipes)
                } catch {
                    onError()
                }
            },
            failure: { _ in onError()}
        )
        
    }
    
}
