//
//  SearchRecipeInteractor.swift
//  recipeSearch
//
//  Created by ahmed osama on 4/1/22.
//  Copyright © 2022 ahmed osama. All rights reserved.
//

import Foundation
class InteractorSearchRecipe:PresenterToInteractorSearchRecipeProtocol{
    
    let networkServices = NetworkServices()
    
    weak var presenter: InteractorToPresenterSearchRecipeProtocol?
    var response: Response?
    
    func fatchResponse(query: String,health: String) {
        networkServices.fetchRecipe(query: query, health: health) { result in
            switch result
            {
            case .success(let response):
                DispatchQueue.main.async {
                    guard let response = response else {return}
                    self.presenter?.fatchResponseSuccess(response: response)
                }
                
            case .failure(let error):
                self.presenter?.fatchResponseFailure(error: error.localizedDescription)
            }
        }
    }
    
    func fatchNextResponse(url: String) {
        networkServices.fetchNextRecipes(url: url, complation: { result in
            switch result
            {
            case .success(let response):
                DispatchQueue.main.async {
                    guard let response = response else {return}
                    self.presenter?.fatchNextResponseSuccess(response: response)
                }
                
            case .failure(let error):
                self.presenter?.fatchNextResponseFailure(error: error.localizedDescription)
            }
        })
    }
    
    
}
