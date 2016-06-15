//
//  RecipesVC.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 5/20/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit
import CoreData

class RecipesVC: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
	
	// MARK: Properties
	@IBOutlet weak var tableView: UITableView!
	
	var fetchedRecipeController: NSFetchedResultsController!
	var fetchedCategoryController: NSFetchedResultsController!
	
	var sampleRecipes = SampleRecipes()
	var allCategories = [Category]()
	var recipesOfCategory = [Recipe]()
	var selectedCategory: Category?
	var categorySelectionIndex: Int?
	var deleteIndex: Int?
	
	
	
	// MARK: Load / Appear Functions
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self

		attemptCategoryFetch()
		selectedCategory = allCategories[categorySelectionIndex!]
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(true)
		attemptRecipeFetch()
		setTitle()
		tableView.reloadData()
	}
	
	
	
	// MARK: Configure Views
	func setTitle() {
		self.navigationItem.title = selectedCategory!.title!.substringFromIndex(selectedCategory!.title!.startIndex.advancedBy(3))
		self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(colorLiteralRed: 0/255, green: 0/255, blue: 0/255, alpha: 1), NSFontAttributeName: UIFont(name: "Hiragino Mincho ProN W6", size: 20.0)!]
	}
	
	
	// MARK: Core Data Fetch
	func attemptRecipeFetch() {
		let fetchRecipeRequest = NSFetchRequest(entityName: "Recipe")
		let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
		fetchRecipeRequest.sortDescriptors = [sortDescriptor]
		
		let controller = NSFetchedResultsController(fetchRequest: fetchRecipeRequest, managedObjectContext: ad.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
		fetchedRecipeController = controller
		
		do {
			try self.fetchedRecipeController.performFetch()
			let allRecipes = fetchedRecipeController.fetchedObjects as! [Recipe]
			recipesOfCategory = allRecipes.filter { NSPredicate(format: "category = %@", selectedCategory!).evaluateWithObject($0) }
		} catch {
			let error = error as NSError
			print("\(error), \(error.userInfo)")
		}
	}
	
	func attemptCategoryFetch() {
		let fetchCategoryRequest = NSFetchRequest(entityName: "Category")
		let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
		fetchCategoryRequest.sortDescriptors = [sortDescriptor]
		
		let controller = NSFetchedResultsController(fetchRequest: fetchCategoryRequest, managedObjectContext: ad.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
		fetchedCategoryController = controller
		
		do {
			try self.fetchedCategoryController.performFetch()
			allCategories = fetchedCategoryController.fetchedObjects as! [Category]
		} catch {
			let error = error as NSError
			print("\(error), \(error.userInfo)")
		}
	}

	
	
	// MARK: NSFetchedResultsController Code
	func controllerWillChangeContent(controller: NSFetchedResultsController) {
		tableView.beginUpdates()
	}
	
	func controllerDidChangeContent(controller: NSFetchedResultsController) {
		tableView.reloadData()
		tableView.endUpdates()
	}
	
	func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
		
		switch(type) {
		case .Insert:
			if let indexPath = newIndexPath {
				tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
			}; break
		case .Delete:
			if let indexPath = indexPath {
				tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
			}; break
		case .Update:
			if let indexPath = indexPath {
				let cell = tableView.cellForRowAtIndexPath(indexPath) as! RecipeCell
				configureCell(cell, indexPath: indexPath)
			}; break
		case .Move:
			if let indexPath = indexPath {
				tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
			}
			if let newIndexPath = newIndexPath {
				tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
			}; break
		}
	}
	
	func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
		switch(type) {
		case .Insert:
			let sectionIndexSet = NSIndexSet(index: sectionIndex)
			self.tableView.insertSections(sectionIndexSet, withRowAnimation: UITableViewRowAnimation.Fade)
			self.tableView.reloadSections(sectionIndexSet, withRowAnimation: .Automatic)
		case .Delete:
			let sectionIndexSet = NSIndexSet(index: sectionIndex)
			self.tableView.deleteSections(sectionIndexSet, withRowAnimation: UITableViewRowAnimation.Fade)
		case .Update:
			let sectionIndexSet = NSIndexSet(index: sectionIndex)
			self.tableView.reloadSections(sectionIndexSet, withRowAnimation: .Automatic)
		default:
			""
		}
		
	}
	
	
	
	// MARK: UITableView Code
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return recipesOfCategory.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell", forIndexPath: indexPath) as! RecipeCell
		configureCell(cell, indexPath: indexPath)
		
		return cell
	}
	
	func configureCell(cell: RecipeCell, indexPath: NSIndexPath) {
		cell.configureCell(recipesOfCategory[indexPath.row])
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let item = recipesOfCategory[indexPath.row]
		
		performSegueWithIdentifier("ShowEditRecipe", sender: item)
	}
	
	func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return true
	}
	
	func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		deleteIndex = indexPath.row
		areYouSureAlert()
	}
	
	func areYouSureAlert() {
		let alertController = UIAlertController(title: "Delete this recipe?", message: "", preferredStyle: .Alert)

		let firstAction = UIAlertAction(title: "Oops, Keep It", style: UIAlertActionStyle.Default, handler: nil)
		let secondAction = UIAlertAction(title: "Delete It", style: UIAlertActionStyle.Destructive, handler: { action in
			let context = ad.managedObjectContext
			context.deleteObject(self.recipesOfCategory[self.deleteIndex!])
			
			self.recipesOfCategory.removeAtIndex(self.deleteIndex!)
			do {
				try context.save()
			} catch {
				print("Error: Unable to save Deletion")
			}
			self.tableView.reloadData()
		} )
		
		alertController.addAction(firstAction)
		alertController.addAction(secondAction)
		self.presentViewController(alertController, animated: true, completion: {})
	}
	
	
	
	// MARK: NAVIGATION
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "ShowEditRecipe" {
			let vc = segue.destinationViewController as! AddRecipeVC
			vc.recipeToEdit = sender as? Recipe
			vc.categorySelectionIndex = categorySelectionIndex
		} else if segue.identifier == "ModalAddRecipe" {
			let nc = segue.destinationViewController as! UINavigationController
			let vc = nc.topViewController as! AddRecipeVC
			vc.categorySelectionIndex = categorySelectionIndex
			vc.modallyPresented = true
		}
	}
	
	
	
	// MARK: Additional Functions
	func deleteAllRecipes() {
		let context = ad.managedObjectContext
		let coord = ad.persistentStoreCoordinator
		
		let fetchRequest = NSFetchRequest(entityName: "Recipe")
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
		
		do {
			try coord.executeRequest(deleteRequest, withContext: context)
		} catch let error as NSError {
			debugPrint(error)
		}
	}

}


