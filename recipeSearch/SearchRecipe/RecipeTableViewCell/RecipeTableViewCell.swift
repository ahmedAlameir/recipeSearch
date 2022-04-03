//
//  RecipeTableViewCell.swift
//  recipeSearch
//
//  Created by ahmed osama on 3/30/22.
//  Copyright © 2022 ahmed osama. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    var HealthLabels:[String]?

    @IBOutlet var recipeImage: UIImageView!
    @IBOutlet var recipeTitle: UILabel!
    @IBOutlet var source: UILabel!
    @IBOutlet var recipeHealthLabels: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib(nibName: "HealthLabelsCollectionViewCell", bundle: nil)
        self.recipeHealthLabels.register(nib, forCellWithReuseIdentifier: "healthLabelsCell")
        self.recipeHealthLabels.delegate=self
        self.recipeHealthLabels.dataSource=self

        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension RecipeTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func updatehealthLabels(healthLabels:[String]) {
        HealthLabels = healthLabels
        recipeHealthLabels.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = HealthLabels?.count else{
            return 0
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "healthLabelsCell", for: indexPath) as! HealthLabelsCollectionViewCell
        guard let HealthLabels = self.HealthLabels else{
            return cell
        }
       

        cell.healthLabels.text = HealthLabels[indexPath.row]
        cell.healthLabels.backgroundColor = .systemTeal
        cell.layer.cornerRadius = 50
        return cell
    }
    
    
}
