//
//  Links.swift
//  recipeSearch
//
//  Created by ahmed osama on 3/30/22.
//  Copyright © 2022 ahmed osama. All rights reserved.
//

import Foundation
struct Links:Codable,Hashable {
    let recipeLink:Link?
    let next:Link?
    
    enum CodingKeys: String, CodingKey {
    case recipeLink = "self"
    case next = "next"
    }
    
}
