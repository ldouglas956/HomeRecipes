//
//  Recipe.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 5/20/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit
import CoreData


class Recipe: Category {

	func setRecipeImage(img: UIImage) {
		let data = UIImagePNGRepresentation(img)
		self.photo = data
	}
	func getRecipeImage() -> UIImage {
		let img = UIImage(data: self.photo!)
		return img!
	}

}

