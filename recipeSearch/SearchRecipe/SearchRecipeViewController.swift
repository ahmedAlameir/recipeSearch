//
//  SearchRecipeViewController.swift
//  recipeSearch
//
//  Created by ahmed osama on 3/30/22.
//  Copyright © 2022 ahmed osama. All rights reserved.
//

import UIKit

class SearchRecipeViewController: UIViewController {
    
    @IBOutlet var searchTableView: UITableView!
    @IBOutlet var healthCatagory: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    
    var presenter: (ViewToPresenterSearchRecipeProtocol & InteractorToPresenterSearchRecipeProtocol)?
    var noResponseLabel = UILabel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        searchBar.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        nibRegester()
        
       setUpLabel()
    }
    func setUpLabel(){
        noResponseLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        noResponseLabel.text =
        """
        the recipe you searching for does not exist
        """
        noResponseLabel.center = self.view.center
        noResponseLabel.numberOfLines=3
        self.view.addSubview(noResponseLabel)
        noResponseLabel.isHidden=true
        
    }
    func nibRegester(){
        var nib = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        self.searchTableView.register(nib, forCellReuseIdentifier: "searchCell")
        nib = UINib(nibName: "HealthLabelsCollectionViewCell", bundle: nil)
        self.healthCatagory.register(nib, forCellWithReuseIdentifier: "healthLabelsCell")
    }
}
    


extension SearchRecipeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.tableViewNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.tableViewSetCell(tableView: searchTableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter?.heightForRowAt() ?? CGFloat(0)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.tableViewWillDisplay(ForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.tableViewDidSelectRowAt(ForRowAt: indexPath)
    }
    
}

extension SearchRecipeViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchBarTextDidChange(searchText: searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return presenter?.searchBarshouldChangeTextIn(text: text, range: range) ?? false
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        presenter?.searchBarTextDidBeginEditing()

    }
}

extension SearchRecipeViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.collectionViewNumberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return presenter?.collectionViewSetItem(collectionView: healthCatagory, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.collectionViewDidSelectItemAt(collectionView: healthCatagory,indexPath: indexPath)
    }
    
    
}
extension SearchRecipeViewController: PresenterToViewSearchRecipeProtocol{
    func reLoadCollectionView() {
        healthCatagory.reloadData()
    }
    
   
    
    func onGettingNoRicpes() {
        searchTableView.isHidden=true
        noResponseLabel.isHidden=false
    }
    
    func hideLabel(){
        noResponseLabel.isHidden=true
    }
    func onFatchResponseSuccess() {
        searchTableView.reloadData()
    }
    
    func onFatchResponseFailure(error: String) {
        

        print(error)
    }
    
    func onFatchNextResponseSuccess() {
        searchTableView.reloadData()
    }
    
    func onFatchNextResponseFailure(error: String) {
        print(error)
    }
    
    func hideTabaleView() {
        searchTableView.isHidden=true
    }
      
    func showTabaleView() {
        searchTableView.isHidden=false
    }
    func onGettingRecentRecipeSuccess(){
        searchTableView.reloadData()
    }
    func onGettingRecentRecipeFailure(error: String){
        print(error)
    }
}
