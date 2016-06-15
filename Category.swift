//
//  Category.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 5/20/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit
import CoreData


class Category: NSManagedObject {

	func setCatImage(img: UIImage) {
		let data = UIImagePNGRepresentation(img)
		self.catPhoto = data
	}
	func getCatImage() -> UIImage {
		let img = UIImage(data: self.catPhoto!)
		return img!
	}
	
}
