//
//  CategoryVC.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 5/20/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit
import CoreData

class CategoryVC: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UINavigationControllerDelegate, UINavigationBarDelegate {
	
	// MARK: Properties
	@IBOutlet weak var tableView: UITableView!
	
	var fetchedResultsController: NSFetchedResultsController!
	var categories = Categories()
	var allCategories = [Category]()
	var sampleRecipes = SampleRecipes()
	var categorySelectionIndex: Int?
	
	
	
	// MARK: Load / Appear Functions
    override func viewDidLoad() {
        super.viewDidLoad()

		tableView.delegate = self
		tableView.dataSource = self
		setNavTitle()
		
		
		fetchCategories()
		if fetchedResultsController.fetchedObjects?.count == 0 {
			categories.initializeCategories()
			fetchCategories()
			sampleRecipes.generateTestData(allCategories)
		}
    }
	
	override func viewDidAppear(animated: Bool) {
		tableView.reloadData()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	
	
	// MARK: Welcome Alert
	func welcomeAlert() {
		// Future Addition
	}
	
	
	
	// MARK: Set Title Image
	func setNavTitle() {
		// Image
//		let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
//		imageView.contentMode = .ScaleAspectFit
//		imageView.image = UIImage(named: "Home-Recipes")
//		navigationItem.titleView = imageView
		
		// Text
		self.navigationController?.navigationBar.translucent = true
		self.navigationItem.title = "Home Recipes"
		self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(colorLiteralRed: 0/255, green: 0/255, blue: 0/255, alpha: 1), NSFontAttributeName: UIFont(name: "Hiragino Mincho ProN W6", size: 30.0)!]
		self.navigationController!.navigationBar.tintColor = UIColor(colorLiteralRed: 0/255, green: 0/255, blue: 0/255, alpha: 1)
		self.navigationController?.navigationBar.backgroundColor = UIColor.clearColor()
		self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 157/255, green: 181/255, blue: 171/255, alpha: 1)
	}


	
	// MARK: Core Data Fetch
	func fetchCategories() {
		let fetchRequest = NSFetchRequest(entityName: "Category")
		let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
		fetchRequest.sortDescriptors = [sortDescriptor]
		
//		let count = ad.managedObjectContext.countForFetchRequest(fetchRecipeRequest, error: nil)
		
		let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: ad.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
		fetchedResultsController = controller
		
		do {
			try self.fetchedResultsController.performFetch()
			allCategories = fetchedResultsController.fetchedObjects as! [Category]
		} catch {
			let error = error as NSError
			print("\(error), \(error.userInfo)")
		}
	}
	
	
	
	// MARK: TableView Code
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return allCategories.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryCell
		if let category = fetchedResultsController.objectAtIndexPath(indexPath) as? Category {
			cell.configureCell(category)
			cell.selectionStyle = UITableViewCellSelectionStyle.None
		}

		return CategoryCell()
	}

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		UITableViewCellSelectionStyle.None
		let selectedCell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
		selectedCell.contentView.backgroundColor = UIColor(colorLiteralRed: 157/255, green: 181/255, blue: 178/255, alpha: 1)
		
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		if let objs = fetchedResultsController.fetchedObjects where objs.count > 0 {
			let item = objs[indexPath.row] as! Category
			categorySelectionIndex = indexPath.row

			performSegueWithIdentifier("ShowListRecipes", sender: item)
		}
	}
	
	
	
	// MARK: NAVIGATION
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "ShowListRecipes" {
			let vc = segue.destinationViewController as! RecipesVC
			vc.categorySelectionIndex = categorySelectionIndex
		} else if segue.identifier == "ModalAddRecipe" {
			
		}
	}
	
}


