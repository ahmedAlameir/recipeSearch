//
//  RecipeDetailsViewController.swift
//  recipeSearch
//
//  Created by ahmed osama on 3/31/22.
//  Copyright © 2022 ahmed osama. All rights reserved.
//

import UIKit
import SafariServices
class RecipeDetailsViewController: UIViewController {
    var recipe:Recipe?
    
    var presenter: (ViewToPresenterRecipeDetailsProtocol& InteractorToPresenterRecipeDetailsProtocol)?

    @IBOutlet var recipeTitle: UILabel!
    @IBOutlet var ingredientTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let labal = self.recipe?.label else{
            return
        }
        recipeTitle.text = labal

    }
    

    @IBAction func shareURL(_ sender: Any) {
        presenter?.shareURL(viewController: self)
    }
    
    @IBAction func openWebsite(_ sender: Any) {
        presenter?.openWebsite(viewController: self)
      
    }
}
extension RecipeDetailsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.tableViewNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        return presenter?.tableViewSetCell(tableView: ingredientTable, cellForRowAt: indexPath) ?? UITableViewCell()
    }
    
    
}
