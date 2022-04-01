//
//  SearchRecipePresenter.swift
//  recipeSearch
//
//  Created by ahmed osama on 4/1/22.
//  Copyright © 2022 ahmed osama. All rights reserved.
//

import UIKit
class SearchRecipePresenter: ViewToPresenterSearchRecipeProtocol{
   
    var response:Response?
    let health = Health()
    private var searchText=String()
    private var healthRequast=String()
   
    
    weak var view: PresenterToViewSearchRecipeProtocol?
    var interactor: PresenterToInteractorSearchRecipeProtocol?
    var router: PresenterToRouterSearchRecipeProtocol?
    
    init(view: PresenterToViewSearchRecipeProtocol, interactor: PresenterToInteractorSearchRecipeProtocol, router: PresenterToRouterSearchRecipeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        // view did loed
    }
    
    func reload() {
        // relod tabel view
    }
    
    func tableViewNumberOfRows() -> Int {
        guard let count = response?.hits?.count else { return 0 }
        return count
    }
    
    func tableViewSetCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! RecipeTableViewCell
            guard let label = self.response?.hits?[indexPath.row].recipe?.label else {
                return cell
            }
            guard let source = self.response?.hits?[indexPath.row].recipe?.source else {
                return cell
            }
            guard let healthLabels = self.response?.hits?[indexPath.row].recipe?.healthLabels else {
                return cell
            }
            cell.recipeTitle.text = label
            cell.source.text = source
            cell.updatehealthLabels(healthLabels:healthLabels)
            return cell
    }
    
    func heightForRowAt() -> CGFloat {
        return CGFloat(250)
    }
    
    func tableViewWillDisplay(ForRowAt indexPath: IndexPath) {
       guard let count = response?.hits?.count else{
            return
        }
        guard let href = response?._links?.next?.href else {
            return
        }
        let lastElement = count-1
        if lastElement == indexPath.row{
            interactor?.fatchNextResponse(url: href)
        }
    }
    
    func tableViewDidSelectRowAt(ForRowAt indexPath: IndexPath) {
        guard let recipe = response?.hits?[indexPath.row].recipe else { return}
        router?.pushToRecipeDetails(on: view, with: recipe)
    }
    
    func searchBarTextDidChange(searchText: String) {
        interactor?.fatchResponse(query: searchText, health: healthRequast)
        self.searchText = searchText
        
    }
    
    func collectionViewNumberOfItems() -> Int {
        return health.health.count
    }
    
    func collectionViewSetItem(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "healthLabelsCell", for: indexPath) as!HealthLabelsCollectionViewCell
        cell.healthLabels.text = health.health[indexPath.row]
        return cell
    }
    
    func collectionViewDidSelectItemAt(indexPath: IndexPath) {
        switch health.health[indexPath.row] {
        case "all":
            healthRequast = ""
        default:
            healthRequast.append(contentsOf: "&health="+health.health[indexPath.row])
        }
        interactor?.fatchResponse(query: searchText, health: healthRequast)
    }
    
    
}
extension SearchRecipePresenter:InteractorToPresenterSearchRecipeProtocol{

    func fatchResponseSuccess(response: Response) {
        self.response = response
        view?.onFatchResponseSuccess()
    }

    func fatchResponseFailure(error: String) {
        view?.onFatchResponseFailure(error: error)
    }

    func fatchNextResponseSuccess(response: Response) {
        guard let to = response.to else {return}
        guard let _links = response._links else {return}
        guard let hits = response.hits else {return}
        self.response?.to=to
        self.response?._links=_links
        self.response?.hits?.append(contentsOf: hits)
        view?.onFatchNextResponseSuccess()
    }

    func fatchNextResponseFailure(error: String) {
        view?.onFatchNextResponseFailure(error: error)
    }
}
