//
//  NetworkServices.swift
//  recipeSearch
//
//  Created by ahmed osama on 3/30/22.
//  Copyright © 2022 ahmed osama. All rights reserved.
//

import Foundation
class NetworkServices {
    let baseURL = "https://api.edamam.com/api/recipes/v2?type=public&q=&app_id=05d81b04&app_key=b179f1aa9fdb0d7e411ec4a96653d02a"

    
    func fetchRecipe(query:String,complation:@escaping(Result<Response?,Error>)->Void) {
        guard let url = URL(string: baseURL.replacingOccurrences(of: "type=public&q=", with: "type=public&q="+query))else{
            return
        }
        let request = URLRequest(url: url)
                  let task = URLSession.shared.dataTask(with: request) { (data, _, erorr) in
                      guard let data = data else{
                          return
                  }
                      do{
                          let result = try JSONDecoder().decode(Response.self, from: data)
                        complation(.success(result))
                      }catch{
                          print("Recipe ")
                      }
                  
              }
                  task.resume()

    }
    
    func fetchNextRecipes(url:String,complation:@escaping(Result<Response?,Error>)->Void) {
        guard let url = URL(string: url) else{
            return
        }
        let request = URLRequest(url: url)
                  let task = URLSession.shared.dataTask(with: request) { (data, _, erorr) in
                      guard let data = data else{
                          return
                  }
                      do{
                          let result = try JSONDecoder().decode(Response.self, from: data)
                        complation(.success(result))
                      }catch{
                          print("Recipe ")
                      }
                  
              }
                  task.resume()

    }
}
