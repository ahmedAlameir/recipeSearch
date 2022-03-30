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
    var response:Response?
    let networkServices = NetworkServices()
    override func viewDidLoad() {
        super.viewDidLoad()
        var nib = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        self.searchTableView.register(nib, forCellReuseIdentifier: "searchCell")
        nib = UINib(nibName: "HealthLabelsCollectionViewCell", bundle: nil)
        self.healthCatagory.register(nib, forCellWithReuseIdentifier: "healthLabelsCell")

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func apiNetWorkCall(query:String){
                networkServices.fetchRecipe(query: query){ result in
            switch result
            {
            case .success(let response):
           
            DispatchQueue.main.async {
                guard let response = response else {return}
                self.response=response
                self.searchTableView.reloadData()
                }

            case .failure(let error):
                print(error)
            }
        }

    }
    func NextApiNetWorkCall(url:String){
                networkServices.fetchNextRecipes(url: url){ result in
            switch result
            {
            case .success(let response):
            DispatchQueue.main.async {
                guard let to = response?.to else {return}
                guard let _links = response?._links else {return}
                guard let hits = response?.hits else {return}
                self.response?.to=to
                self.response?._links=_links
                self.response?.hits?.append(contentsOf: hits)
                self.searchTableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }

    }

}
extension SearchRecipeViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         guard let count = response?.hits?.count else{
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! RecipeTableViewCell
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(250)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let count = response?.hits?.count else{
            return
        }
        guard let href = response?._links?.next?.href else {
            return
        }
        let lastElement = count-1
        if lastElement == indexPath.row{
            self.NextApiNetWorkCall(url: href)
            
        }
    }
    
}
extension SearchRecipeViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        apiNetWorkCall(query: searchText)
    }

}
