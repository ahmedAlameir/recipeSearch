//
//  Ingredient.swift
//  recipeSearch
//
//  Created by ahmed osama on 3/30/22.
//  Copyright © 2022 ahmed osama. All rights reserved.
//

import Foundation
struct Ingredient:Codable {
    let text:String?
    let quantity:Double?
    let measure:String?
    let food:String?
    let weight:Double?
    let foodId:String?
}
