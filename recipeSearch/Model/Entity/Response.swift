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
    var to :Int?
    let count :Int?
    var _links :Links?
    var hits :[Hit]?



     
    
}
