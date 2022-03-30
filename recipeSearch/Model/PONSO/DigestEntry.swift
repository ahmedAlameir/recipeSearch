//
//  DigestEntry.swift
//  recipeSearch
//
//  Created by ahmed osama on 3/30/22.
//  Copyright © 2022 ahmed osama. All rights reserved.
//

import Foundation
struct DigestEntry : Codable {
    let label:String?
    let tag:String?
    let schemaOrgTag:String?
    let total:Double?
    let hasRDI:Bool?
    let daily:Double?
    let unit:String?
    let sub:[DigestEntry]?
}
