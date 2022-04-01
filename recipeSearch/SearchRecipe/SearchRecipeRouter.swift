//
//  SearchRecipeRouter.swift
//  recipeSearch
//
//  Created by ahmed osama on 4/1/22.
//  Copyright © 2022 ahmed osama. All rights reserved.
//

import UIKit
class RouterSearchRecipe:PresenterToRouterSearchRecipeProtocol{
    weak var viewController: UIViewController?

    static func createMoudle() -> UIViewController? {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(SearchRecipeViewController.self)") as! SearchRecipeViewController
        let interactor = InteractorSearchRecipe()
        let router = RouterSearchRecipe()
        let presenter = SearchRecipePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func pushToRecipeDetails(on view: PresenterToViewSearchRecipeProtocol?, with recipe: Recipe) {
        //navgat
    }
    
    
}
