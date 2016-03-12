//
//  RecipeSearchResult.swift
//  never-go-bad
//
//  Created by Andre Oriani on 3/11/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import Foundation
import ELCodable

struct RecipeSearchResult:Decodable {
    
    struct Recipe: Decodable {
        var name: String
        var image: String?
        var id: String
        var rating: Decimal?
        
        static func decode(json: JSON?) throws -> Recipe {
            return try Recipe (
                name: json ==> "name",
                image: json ==> "image",
                id: json ==> "id",
                rating: json ==> "rating"
            )
        }
    }
    
    var recipes: [Recipe]
    var hasMore: Bool
    
    static func decode(json: JSON?) throws -> RecipeSearchResult {
        return try RecipeSearchResult (
            recipes: json ==> "recipes",
            hasMore: json ==> "hasMore"
        )
    }
    
}