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

    @IBOutlet var recipeTitle: UILabel!
    @IBOutlet var ingredientTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let labal = self.recipe?.label else{
            return
        }
        recipeTitle.text = labal


        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func shearSours(_ sender: Any) {
        guard let url = recipe?.url else{
            return
        }
        let urlToShare = [ url ]
        let activityViewController = UIActivityViewController(activityItems: urlToShare, applicationActivities: nil )
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func openWebsite(_ sender: Any) {
        guard let urlStr = recipe?.url else{
                 return
             }
        guard let url = URL(string: urlStr)  else{
                 return
             }
        let vc = SFSafariViewController(url: url, configuration: SFSafariViewController.Configuration())
        present(vc, animated: true)
    }
}
extension RecipeDetailsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = recipe?.ingredientLines?.count else{
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientTable.dequeueReusableCell(withIdentifier: "ingredient", for: indexPath)
        guard let ingredient = recipe?.ingredientLines?[indexPath.row] else{
            return cell
        }
        cell.textLabel?.text = ingredient
        return cell
    }
    
    
}
