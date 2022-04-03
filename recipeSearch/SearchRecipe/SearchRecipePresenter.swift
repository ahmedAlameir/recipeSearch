//
//  SearchRecipePresenter.swift
//  recipeSearch
//
//  Created by ahmed osama on 4/1/22.
//  Copyright © 2022 ahmed osama. All rights reserved.
//

import UIKit
import SDWebImage
class SearchRecipePresenter: ViewToPresenterSearchRecipeProtocol{
   
    var response:Response?
    let health = Health()
    private var searchText=String()
    private var healthRequast=String()
    var savedRcipe = [Hit]()
    var savedRcipeFilter:Bool = true
    var image = UIImage()
    
    
    weak var view: PresenterToViewSearchRecipeProtocol?
    var interactor: PresenterToInteractorSearchRecipeProtocol?
    var router: PresenterToRouterSearchRecipeProtocol?
    
    init(view: PresenterToViewSearchRecipeProtocol, interactor: PresenterToInteractorSearchRecipeProtocol, router: PresenterToRouterSearchRecipeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.hideTabaleView()
        interactor?.getRecentRecipe()

    }
    
    func reload() {
        // relod tabel view
    }
    
    func tableViewNumberOfRows() -> Int {
        if savedRcipeFilter == true {
            return savedRcipe.count
        }else{
        guard let count = response?.hits?.count else { return 0 }
        return count
        }
    }
    
    func tableViewSetCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! RecipeTableViewCell
        if savedRcipeFilter == true {
            cell.recipeTitle.text = savedRcipe[indexPath.row].recipe?.label
            cell.source.text = savedRcipe[indexPath.row].recipe?.source
            guard let healthLabels = self.savedRcipe[indexPath.row].recipe?.healthLabels else {
                return cell
            }
            guard let imageURL = self.savedRcipe[indexPath.row].recipe?.image else { return cell }
            cell.recipeImage.sd_setImage(with: URL(string: imageURL))
            cell.updatehealthLabels(healthLabels: healthLabels)
        }else{
        guard let label = self.response?.hits?[indexPath.row].recipe?.label else {
            return cell
        }
        guard let source = self.response?.hits?[indexPath.row].recipe?.source else {
               return cell
        }
        guard let healthLabels = self.response?.hits?[indexPath.row].recipe?.healthLabels else {
            return cell
        }
            guard let imageURL = self.response?.hits?[indexPath.row].recipe?.image else { return cell }
            cell.recipeImage.sd_setImage(with: URL(string: imageURL))
        cell.recipeTitle.text = label
        cell.source.text = source
        cell.updatehealthLabels(healthLabels:healthLabels)
        }
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
        if savedRcipeFilter == true {
            guard let recipe = self.savedRcipe[indexPath.row].recipe else{return}
            router?.pushToRecipeDetails(on: view, with: recipe)
        }else{
        guard let recipe = response?.hits?[indexPath.row].recipe else { return}
        guard let hit = response?.hits?[indexPath.row] else { return}
        var conter = 0
            for recipe in savedRcipe {
                if recipe.recipe?.label == hit.recipe?.label{
                    
                    savedRcipe.remove(at: conter)
                }
                conter += 1
            }
        self.savedRcipe.insert(hit, at: 0)
           
            
        let count = savedRcipe.count
        if count > 10{
            savedRcipe.removeSubrange(10...count)
        }
         let hits = savedRcipe
        interactor?.saveRecentRecipe(recipes: hits)
        router?.pushToRecipeDetails(on: view, with: recipe)
        }
    }
    
    func searchBarTextDidChange(searchText: String) {
        view?.hideLabel()
        view?.showTabaleView()
        if searchText == ""{
            savedRcipeFilter = true
            interactor?.getRecentRecipe()
        }else{
            savedRcipeFilter = false
        
        
        self.searchText = searchText.replacingOccurrences(of: " ", with: "%20")
    
        print(self.searchText)
        interactor?.fatchResponse(query: self.searchText, health: healthRequast)
        }
    }
    
    func searchBarshouldChangeTextIn(text:String ,range: NSRange)->Bool{
        if range.lowerBound == 0 && text == " "{
            return false
        }
        let allowedCharacters = CharacterSet(charactersIn:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvxyz ").inverted
        let components = text.components(separatedBy: allowedCharacters)
        let filtered = components.joined(separator: "")
        if text == filtered {
            return true
        } else {
            return false
        }
    }
    func searchBarTextDidBeginEditing(){
        savedRcipeFilter = true
        view?.showTabaleView()
        savedRcipeFilter = true
        view?.onGettingRecentRecipeSuccess()
    }

    
    func collectionViewNumberOfItems() -> Int {
        return health.health.count
    }
    
    func collectionViewSetItem(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "healthLabelsCell", for: indexPath) as!HealthLabelsCollectionViewCell
        cell.healthLabels.text = health.health[indexPath.row]
        cell.healthLabels.backgroundColor = .lightGray
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func collectionViewDidSelectItemAt(collectionView: UICollectionView,indexPath: IndexPath) {
        if savedRcipeFilter == false {
        switch health.health[indexPath.row] {
        case "all":
            healthRequast = ""
            view?.reLoadCollectionView()
        default:
            healthRequast.append(contentsOf: "&health="+health.health[indexPath.row])
            let selectedCell = collectionView.cellForItem(at: indexPath) as! HealthLabelsCollectionViewCell
            
            selectedCell.healthLabels.backgroundColor = .systemTeal
        }
        
        interactor?.fatchResponse(query: searchText, health: healthRequast)
        }
    }
    
    
}
extension SearchRecipePresenter:InteractorToPresenterSearchRecipeProtocol{
    
    
   
    func fatchResponseSuccess(response: Response) {
        self.response = response
        if self.response?.count == 0 {
            view?.onGettingNoRicpes()
        }else{
        view?.onFatchResponseSuccess()
    }
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
    func getRecentRecipeSuccess(recipes: [Hit]) {
        
        self.savedRcipe = recipes
        view?.onGettingRecentRecipeSuccess()
    }
       
    func getRecentRecipeFailure(error: String) {
        view?.onGettingRecentRecipeFailure(error: error)
    }
}
