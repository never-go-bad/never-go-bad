//
//  BarcodeResult.swift
//  APItests
//
//  Created by Andre Oriani on 3/1/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation
import ELCodable

struct BarcodeResult: Decodable {
    
    struct Product: Decodable {
        var factual_id: String?
        var brand: String?
        var product_name: String?
        var size: [String]?
        var upc: String?
        var ean13: String?
        var category: String?
        var manufacturer: String?
        var avg_price: Decimal?
        var ingredients: [String]?
        var serving_size: String?
        var servings: Decimal?
        var calories: Decimal?
        var fat_calories:  Decimal?
        var total_fat: Decimal?
        var sat_fat: Decimal?
        var polyunsat_fat: Decimal?
        var monounsat_fat: Decimal?
        var trans_fat: Decimal?
        var cholesterol: Decimal?
        var sodium: Decimal?
        var potassium: Decimal?
        var total_carb: Decimal?
        var dietary_fiber: Decimal?
        var soluble_fiber: Decimal?
        var insoluble_fiber: Decimal?
        var sugar_alcohol: Decimal?
        var sugars: Decimal?
        var protein: Decimal?
        var calcium: Decimal?
        var iron: Decimal?
        var vitamin_a: Decimal?
        var vitamin_c: Decimal?
        var image_urls: [String]?
        var upc_e: String?
        
        static func decode(json: JSON?) throws -> Product {
                        
            return try Product(factual_id:json ==> "factual_id",
                brand:json ==> "brand",
                product_name:json ==> "product_name",
                size:json ==> "size",
                upc:json ==> "upc",
                ean13:json ==> "ean13",
                category:json ==> "category",
                manufacturer:json ==> "manufacturer",
                avg_price:json ==> "avg_price",
                ingredients:json ==> "ingredients",
                serving_size:json ==> "serving_size",
                servings:json ==> "servings",
                calories:json ==> "calories",
                fat_calories:json ==> "fat_calories",
                total_fat:json ==> "total_fat",
                sat_fat:json ==> "sat_fat",
                polyunsat_fat:json ==> "polyunsat_fat",
                monounsat_fat:json ==> "monounsat_fat",
                trans_fat:json ==> "trans_fat",
                cholesterol:json ==> "cholesterol",
                sodium:json ==> "sodium",
                potassium:json ==> "potassium",
                total_carb:json ==> "total_carb",
                dietary_fiber:json ==> "dietary_fiber",
                soluble_fiber:json ==> "soluble_fiber",
                insoluble_fiber:json ==> "insoluble_fiber",
                sugar_alcohol:json ==> "sugar_alcohol",
                sugars:json ==> "sugars",
                protein:json ==> "protein",
                calcium:json ==> "calcium",
                iron:json ==> "iron",
                vitamin_a:json ==> "vitamin_a",
                vitamin_c:json ==> "vitamin_c",
                image_urls:json ==> "image_urls",
                upc_e:json ==> "upc_e")
        }
    }
    
    struct Response: Decodable {
        var data:[Product]
        var includedRows:Int
        static func decode(json: JSON?) throws -> Response {
            return try Response(
                data: json ==> "data",
                includedRows: json ==> "included_rows"
            )
        }
    }
    
    var version:Int
    var status:String
    var response:Response
    
    static func decode(json: JSON?) throws -> BarcodeResult {
        return try BarcodeResult (
            version: json ==> "version",
            status: json ==> "status",
            response: json ==> "response")
    }
}
