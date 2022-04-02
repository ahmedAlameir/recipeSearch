//
//  RecipeDetailRouter.swift
//  recipeSearch
//
//  Created by ahmed osama on 4/2/22.
//  Copyright © 2022 ahmed osama. All rights reserved.
//

import UIKit
class RecipeDetailsRouter: PresenterToRouterRecipeDetailsProtocol{
    static func creatModule(with recipe: Recipe) -> UIViewController? {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(RecipeDetailsViewController.self)") as! RecipeDetailsViewController
        let interactor = RecipeDetailInteractor()
        interactor.recipe = recipe
        let router = RecipeDetailsRouter()
        let presenter = RecipeDetailPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
    
    
}
