//
//  Recipe.swift
//  recipeSearch
//
//  Created by ahmed osama on 3/30/22.
//  Copyright © 2022 ahmed osama. All rights reserved.
//

import Foundation
struct Recipe:Codable,Hashable {
    let uri :String?
    let label :String?
    let image :String?
    let images :InlineModel1?
    let source :String?
    let url :String?
    let shareAs :String?
    let yield :Double?
    let dietLabels :[String]?
    let healthLabels :[String]?
    let cautions :[String]?
    let ingredientLines :[String]?
    let ingredients :[Ingredient]?
    let calories :Double?
    let totalWeight :Double?
    let totalTime :Double?
    let cuisineType :[String]?
    let mealType :[String]?
    let dishType :[String]?
    let digest :[DigestEntry]?

}
