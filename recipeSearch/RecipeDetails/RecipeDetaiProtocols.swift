//
//  RecipeDetaiProtocols.swift
//  recipeSearch
//
//  Created by ahmed osama on 4/2/22.
//  Copyright © 2022 ahmed osama. All rights reserved.
//

import UIKit

protocol ViewToPresenterRecipeDetailsProtocol {
    var view: PresenterToViewRecipeDetailsProtocol? { get set }
    var interactor: PresenterToInteractorRecipeDetailsProtocol? { get set }
    var router: PresenterToRouterRecipeDetailsProtocol? { get set }
    
    func viewDidLoad()
    func reload()
    func populateDataIn(recipeImageView:UIImageView,recipeLabel:UILabel)
    
    func shareURL(viewController:UIViewController)
    
    func openWebsite(viewController: UIViewController)
    
    func tableViewNumberOfRows() -> Int
    func tableViewSetCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

protocol PresenterToViewRecipeDetailsProtocol: AnyObject {
    func onFatchImageSuccess()
    func onFatchImageFailure(error: String)
}

protocol PresenterToInteractorRecipeDetailsProtocol{
    var presenter: InteractorToPresenterRecipeDetailsProtocol? { get set }
    var recipe: Recipe? {get set}
    func fatchImageData()
}

protocol InteractorToPresenterRecipeDetailsProtocol: AnyObject {
    func fatchImageSuccess(recipe:Recipe?,image: UIImage)
    func fatchImageFailure(error: String)
}

protocol PresenterToRouterRecipeDetailsProtocol{
    static func creatModule(with recipe:Recipe)->UIViewController?
}


