//
//  RecipeCell.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 5/16/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {
	
	@IBOutlet private weak var recipeName: UILabel!
	@IBOutlet private weak var recipeImage: UIImageView!
	

    override func awakeFromNib() {
        super.awakeFromNib()
		recipeImage.layer.cornerRadius = recipeImage.frame.size.height/2
		recipeImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	func configureCell(recipe: Recipe) {
		recipeName.text = recipe.name
		recipeImage.image = recipe.getRecipeImage()
		recipeImage.image = recipeImage.image?.correctlyOrientedImage()
	}

}
