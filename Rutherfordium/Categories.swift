//
//  Categories.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 6/7/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit
import CoreData

class Categories {
	
	func initializeCategories() {
		let category1 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category2 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category3 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category4 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category5 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category6 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category7 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category8 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		let category9 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: ad.managedObjectContext) as! Category
		
		category1.title = "7) Breakfast"
		category2.title = "6) Dessert"
		category3.title = "9) Drinks"
		category4.title = "4) Main Course"
		category5.title = "3) Salad"
		category6.title = "5) Sides"
		category7.title = "8) Snacks"
		category8.title = "2) Soup / Chili"
		category9.title = "1) Appetizers"
		
		category1.setCatImage(UIImage(named: "breakfast")!)
		category2.setCatImage(UIImage(named: "dessert")!)
		category3.setCatImage(UIImage(named: "drinks")!)
		category4.setCatImage(UIImage(named: "mainCourse")!)
		category5.setCatImage(UIImage(named: "salad")!)
		category6.setCatImage(UIImage(named: "sides")!)
		category7.setCatImage(UIImage(named: "snacks")!)
		category8.setCatImage(UIImage(named: "soup")!)
		category9.setCatImage(UIImage(named: "appetizers")!)
		
		ad.saveContext()
	}
	
}
