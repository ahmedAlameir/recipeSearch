//
//  Response.swift
//  recipeSearch
//
//  Created by ahmed osama on 3/30/22.
//  Copyright © 2022 ahmed osama. All rights reserved.
//

import Foundation
struct Response : Codable{
    let from :Int?
    let to :Int?
    let count :Int?
    let _links :Links?
    let hits :[Hit]?



     
    
}
