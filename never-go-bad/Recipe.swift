//
//  Recipe.swift
//  never-go-bad
//
//  Created by Andre Oriani on 3/11/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import Foundation
import ELCodable


struct Recipe: Decodable {
    
    struct IngredientGroup: Decodable {
        var groupName: String?
        var ingredients: [String]
        
        static func decode(json: JSON?) throws -> IngredientGroup {
            return try IngredientGroup(
                groupName: json ==> "groupName",
                ingredients: json ==> "ingredients"
            )
        }
    }
    
    struct PreparationStepGroup: Decodable {
        var groupName: String?
        var steps: [String]
        
        static func decode(json: JSON?) throws -> PreparationStepGroup {
            return try PreparationStepGroup(
                groupName: json ==> "groupName",
                steps: json ==> "steps"
            )
        }
        
    }
    
    var name: String
    var rating: Decimal
    var wouldPrepareAgain: String
    var description: String?
    var image: String?
    var servings: String?
    var activeTime: String?
    var totalTime: String?
    var chefNotes: String?
    var ingredientGroups: [IngredientGroup]
    var preparationStepGroups: [PreparationStepGroup]
    var html:String
    var servingsHtml: String
    
    static func decode(json: JSON?) throws -> Recipe {
        return try Recipe(
            name: json ==> "name",
            rating: json ==> "rating",
            wouldPrepareAgain: json ==> "wouldPrepareAgain",
            description: json ==> "description",
            image: json ==> "image",
            servings: json ==> "servings",
            activeTime: json ==> "activeTime",
            totalTime: json ==> "totalTime",
            chefNotes: json ==> "chefNotes",
            ingredientGroups: json ==> "ingredientGroups",
            preparationStepGroups: json ==> "preparationStepGroups",
            html: json ==> "html",
            servingsHtml: json ==> "servingsHtml"
        )
    }
}

