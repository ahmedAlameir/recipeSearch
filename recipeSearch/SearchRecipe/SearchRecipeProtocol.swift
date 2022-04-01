//
//  SearchRecipeProtocol.swift
//  recipeSearch
//
//  Created by ahmed osama on 4/1/22.
//  Copyright © 2022 ahmed osama. All rights reserved.
//

import UIKit

// MARK: - View output (View -> Presenter)
protocol ViewToPresenterSearchRecipeProtocol {
    var view: PresenterToViewSearchRecipeProtocol? { get set }
    var interactor: PresenterToInteractorSearchRecipeProtocol? { get set }
    var router: PresenterToRouterSearchRecipeProtocol? { get set }
    func viewDidLoad()
    func reload()
    
    func tableViewNumberOfRows() -> Int
    func tableViewSetCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func heightForRowAt() -> CGFloat
    func tableViewWillDisplay(ForRowAt indexPath: IndexPath)
    func tableViewDidSelectRowAt(ForRowAt indexPath: IndexPath)
    
    func searchBarTextDidChange(searchText: String)
    
    func collectionViewNumberOfItems() -> Int
    func collectionViewSetItem (collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func collectionViewDidSelectItemAt (indexPath: IndexPath)
}

// MARK: - View input (Presenter -> View)
protocol PresenterToViewSearchRecipeProtocol: AnyObject {
    func onFatchResponseSuccess()
    func onFatchResponseFailure(error: String)
    func onFatchNextResponseSuccess()
    func onFatchNextResponseFailure(error: String)
}

// MARK: - Interactor input (Presenter -> Interactor)
protocol PresenterToInteractorSearchRecipeProtocol {
    var presenter: InteractorToPresenterSearchRecipeProtocol? { get set }
    var response: Response? {get set}
    func fatchResponse(query:String ,health:String)
    func fatchNextResponse(url: String)
}

// MARK: - Interactor output (Interactor -> Presenter)
protocol InteractorToPresenterSearchRecipeProtocol: AnyObject {
    func fatchResponseSuccess(response: Response)
    func fatchResponseFailure(error: String)
    func fatchNextResponseSuccess(response: Response)
    func fatchNextResponseFailure(error: String)

}

// MARK: - Router input (Router -> Interactor)
protocol PresenterToRouterSearchRecipeProtocol {
    static func createMoudle() -> UIViewController?
    func pushToRecipeDetails(on view: PresenterToViewSearchRecipeProtocol?,with recipe: Recipe)
}

