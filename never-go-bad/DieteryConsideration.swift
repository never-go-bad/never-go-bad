//
//  DieteryConsideration.swift
//  never-go-bad
//
//  Created by Kanch on 3/20/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import Foundation

enum DietaryConsiderationEnum : String {
	case Healthy, Vegan, LowCholesterol, Kosher, Raw, KosherPesach
}

class DieteryConsideration {
    
    static let dieteryConsiderations: [DieteryConsideration] = [
        DieteryConsideration(dietType: DietaryConsiderationEnum.Healthy , code: "652", selected: true),
        DieteryConsideration(dietType: DietaryConsiderationEnum.Vegan, code: "656", selected: true),
        DieteryConsideration(dietType: DietaryConsiderationEnum.LowCholesterol, code: "655", selected: true, displayName: "Low Cholestrol"),
        DieteryConsideration(dietType: DietaryConsiderationEnum.Kosher, code: "645", selected: true),
        DieteryConsideration(dietType: DietaryConsiderationEnum.Raw, code: "659", selected: true),
        DieteryConsideration(dietType: DietaryConsiderationEnum.KosherPesach, code: "658", selected: true, displayName: "Kosher Pesach")
    ]
    
	var dietType : DietaryConsiderationEnum
	var code : String
	var selected : Bool
	var displayName: String

	init(dietType: DietaryConsiderationEnum, code: String, selected: Bool, displayName: String) {
		self.dietType = dietType
		self.code = code
		self.selected = selected
		self.displayName = displayName
	}

	convenience init(dietType: DietaryConsiderationEnum, code: String, selected: Bool) {
		self.init(dietType: dietType, code: code, selected: selected, displayName: String(dietType))
	}
}