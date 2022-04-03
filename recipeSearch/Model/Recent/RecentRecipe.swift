//
//  RecentRecipe.swift
//  recipeSearch
//
//  Created by ahmed osama on 4/2/22.
//  Copyright © 2022 ahmed osama. All rights reserved.
//

import Foundation
class RecentRecipe {
    func saveRecipesData(recipes:[Hit]){
        do {
            let data  = try JSONEncoder().encode(recipes)
            UserDefaults.standard.set(data,forKey: "recipes")
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func getRecipes(complation:@escaping(Result<[Hit],Error>)->Void) {
        if let data = UserDefaults.standard.data(forKey: "recipes"){
            do {
                let result = try JSONDecoder().decode([Hit].self, from: data)
                complation(.success(result))
            } catch  {
                complation(.failure(error))
                print(error.localizedDescription)
            }
        }
    }
}
