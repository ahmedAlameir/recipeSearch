//
//  RecipeDetailPresenter.swift
//  recipeSearch
//
//  Created by ahmed osama on 4/2/22.
//  Copyright © 2022 ahmed osama. All rights reserved.
//

import UIKit
import SafariServices

class RecipeDetailPresenter:ViewToPresenterRecipeDetailsProtocol{
    
    var view: PresenterToViewRecipeDetailsProtocol?
    var interactor: PresenterToInteractorRecipeDetailsProtocol?
    var router: PresenterToRouterRecipeDetailsProtocol?

    var recipe:Recipe?
    
    var image:UIImage?
    
    init(view: PresenterToViewRecipeDetailsProtocol, interactor: PresenterToInteractorRecipeDetailsProtocol, router: PresenterToRouterRecipeDetailsProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        interactor?.fatchImageData()
    }
    
    func reload() {
        //
    }
    
    func populateDataIn(recipeImageView: UIImageView, recipeLabel: UILabel) {
        recipeImageView.image = image
        guard let label = recipe?.label else {return}
        recipeLabel.text = label
        
    }
    
    func shareURL(viewController: UIViewController) {
        guard let url = recipe?.url else { return }
        let urlToShare = [ url ]
        let activityViewController = UIActivityViewController(activityItems: urlToShare, applicationActivities: nil )
        activityViewController.popoverPresentationController?.sourceView = viewController.view
        viewController.present(activityViewController, animated: true, completion: nil)
    }
    
    
    func openWebsite(viewController: UIViewController) {
        guard let urlStr = recipe?.url else { return }
        guard let url = URL(string: urlStr)  else { return }
        let vc = SFSafariViewController(url: url, configuration: SFSafariViewController.Configuration())
        viewController.present(vc, animated: true)
    }
        
    
    
    func tableViewNumberOfRows() -> Int {
        guard let count = recipe?.ingredientLines?.count else{
            return 0
        }
        return count
        
    }
    
    func tableViewSetCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredient", for: indexPath)
        guard let ingredient = recipe?.ingredientLines?[indexPath.row] else {return cell}
        cell.textLabel?.text = ingredient
        return cell
    }
    
    
}
extension RecipeDetailPresenter:InteractorToPresenterRecipeDetailsProtocol{
    func fatchImageSuccess(recipe: Recipe?, image: UIImage) {
        self.image = image
        self.recipe=recipe
        view?.onFatchImageSuccess()
    }
    
    func fatchImageFailure(error: String) {
        view?.onFatchImageFailure(error: error)
    }
    
    
}

