//
//  RecipeDetailInteractor.swift
//  recipeSearch
//
//  Created by ahmed osama on 4/2/22.
//  Copyright © 2022 ahmed osama. All rights reserved.
//

import UIKit
class RecipeDetailInteractor: PresenterToInteractorRecipeDetailsProtocol {
    var presenter: InteractorToPresenterRecipeDetailsProtocol?
    let networkServices = NetworkServices()
    
    var image = UIImage()
    
    var recipe: Recipe?
    
    func fatchImageData() {
        guard let urlstr = recipe?.image else {return}
        //guard let url = URL(string: urlstr) else {return}
        networkServices.getImage(from: urlstr, completion: { result in
            switch result
            {
            case .success(let image):
                DispatchQueue.main.async {
                    guard let image1 = image else{return}
                    self.image = UIImage(data: image1)!
                    self.presenter?.fatchImageSuccess(recipe: self.recipe, image: self.image)
                    
                }
                
                
            case .failure(let error):
                self.presenter?.fatchImageFailure(error: error.localizedDescription)
            }
        })
        
    }
    
    
}
