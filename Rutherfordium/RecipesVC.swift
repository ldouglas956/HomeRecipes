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
	
	var fetchedRecipeController: NSFetchedResultsController<NSFetchRequestResult>?
	var fetchedCategoryController: NSFetchedResultsController<NSFetchRequestResult>?
	
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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		attemptRecipeFetch()
		setTitle()
		tableView.reloadData()
	}
	
	
	
	// MARK: Configure Views
	func setTitle() {
		self.navigationItem.title = selectedCategory!.title!.substring(from: selectedCategory!.title!.characters.index(selectedCategory!.title!.startIndex, offsetBy: 3))
		self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(colorLiteralRed: 0/255, green: 0/255, blue: 0/255, alpha: 1), NSFontAttributeName: UIFont(name: "Hiragino Mincho ProN W6", size: 20.0)!]
	}
	
	
	// MARK: Core Data Fetch
	func attemptRecipeFetch() {
		let fetchRecipeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
		let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
		fetchRecipeRequest.sortDescriptors = [sortDescriptor]
		
		let controller = NSFetchedResultsController(fetchRequest: fetchRecipeRequest, managedObjectContext: ad.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
		fetchedRecipeController = controller
		
		do {
			try self.fetchedRecipeController?.performFetch()
			let allRecipes = fetchedRecipeController?.fetchedObjects as! [Recipe]
			recipesOfCategory = allRecipes.filter { NSPredicate(format: "category = %@", selectedCategory!).evaluate(with: $0) }
		} catch {
			let error = error as NSError
			print("\(error), \(error.userInfo)")
		}
	}
	
	func attemptCategoryFetch() {
		let fetchCategoryRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
		let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
		fetchCategoryRequest.sortDescriptors = [sortDescriptor]
		
		let controller = NSFetchedResultsController(fetchRequest: fetchCategoryRequest, managedObjectContext: ad.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
		fetchedCategoryController = controller
		
		do {
			try self.fetchedCategoryController?.performFetch()
			allCategories = fetchedCategoryController?.fetchedObjects as! [Category]
		} catch {
			let error = error as NSError
			print("\(error), \(error.userInfo)")
		}
	}

	
	
	// MARK: NSFetchedResultsController Code
	func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		tableView.beginUpdates()
	}
	
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		tableView.reloadData()
		tableView.endUpdates()
	}
	
	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
		
		switch(type) {
		case .insert:
			if let indexPath = newIndexPath {
				tableView.insertRows(at: [indexPath], with: .fade)
			}; break
		case .delete:
			if let indexPath = indexPath {
				tableView.deleteRows(at: [indexPath], with: .fade)
			}; break
		case .update:
			if let indexPath = indexPath {
				let cell = tableView.cellForRow(at: indexPath) as! RecipeCell
				configureCell(cell, indexPath: indexPath)
			}; break
		case .move:
			if let indexPath = indexPath {
				tableView.deleteRows(at: [indexPath], with: .fade)
			}
			if let newIndexPath = newIndexPath {
				tableView.insertRows(at: [newIndexPath], with: .fade)
			}; break
		}
	}
	
	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
		switch(type) {
		case .insert:
			let sectionIndexSet = IndexSet(integer: sectionIndex)
			self.tableView.insertSections(sectionIndexSet, with: UITableViewRowAnimation.fade)
			self.tableView.reloadSections(sectionIndexSet, with: .automatic)
		case .delete:
			let sectionIndexSet = IndexSet(integer: sectionIndex)
			self.tableView.deleteSections(sectionIndexSet, with: UITableViewRowAnimation.fade)
		case .update:
			let sectionIndexSet = IndexSet(integer: sectionIndex)
			self.tableView.reloadSections(sectionIndexSet, with: .automatic)
		case .move: break
			
//		default:
//			""
		}
		
	}
	
	
	
	// MARK: UITableView Code
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return recipesOfCategory.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
		configureCell(cell, indexPath: indexPath)
		
		return cell
	}
	
	func configureCell(_ cell: RecipeCell, indexPath: IndexPath) {
		cell.configureCell(recipesOfCategory[(indexPath as NSIndexPath).row])
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let item = recipesOfCategory[(indexPath as NSIndexPath).row]
		
		performSegue(withIdentifier: "ShowEditRecipe", sender: item)
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		deleteIndex = (indexPath as NSIndexPath).row
		areYouSureAlert()
	}
	
	func areYouSureAlert() {
		let alertController = UIAlertController(title: "Delete this recipe?", message: "", preferredStyle: .alert)

		let firstAction = UIAlertAction(title: "Oops, Keep It", style: UIAlertActionStyle.default, handler: nil)
		let secondAction = UIAlertAction(title: "Delete It", style: UIAlertActionStyle.destructive, handler: { action in
			let context = ad.managedObjectContext
			context.delete(self.recipesOfCategory[self.deleteIndex!])
			
			self.recipesOfCategory.remove(at: self.deleteIndex!)
			do {
				try context.save()
			} catch {
				print("Error: Unable to save Deletion")
			}
			self.tableView.reloadData()
		} )
		
		alertController.addAction(firstAction)
		alertController.addAction(secondAction)
		self.present(alertController, animated: true, completion: {})
	}
	
	
	
	// MARK: NAVIGATION
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "ShowEditRecipe" {
			let vc = segue.destination as! AddRecipeVC
			vc.recipeToEdit = sender as? Recipe
			vc.categorySelectionIndex = categorySelectionIndex
		} else if segue.identifier == "ModalAddRecipe" {
			let nc = segue.destination as! UINavigationController
			let vc = nc.topViewController as! AddRecipeVC
			vc.categorySelectionIndex = categorySelectionIndex
			vc.modallyPresented = true
		}
	}
	
	
	
	// MARK: Additional Functions
	func deleteAllRecipes() {
		let context = ad.managedObjectContext
		let coord = ad.persistentStoreCoordinator
		
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
		
		do {
			try coord.execute(deleteRequest, with: context)
		} catch let error as NSError {
			debugPrint(error)
		}
	}

}


