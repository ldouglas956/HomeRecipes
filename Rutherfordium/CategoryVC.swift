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
	
	var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
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
		if fetchedResultsController?.fetchedObjects?.count == 0 {
			categories.initializeCategories()
			fetchCategories()
			sampleRecipes.generateTestData(allCategories)
		}
    }
	
	override func viewDidAppear(_ animated: Bool) {
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
		self.navigationController?.navigationBar.isTranslucent = true
		self.navigationItem.title = "Home Recipes"
		self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(colorLiteralRed: 0/255, green: 0/255, blue: 0/255, alpha: 1), NSFontAttributeName: UIFont(name: "Hiragino Mincho ProN W6", size: 30.0)!]
		self.navigationController!.navigationBar.tintColor = UIColor(colorLiteralRed: 0/255, green: 0/255, blue: 0/255, alpha: 1)
		self.navigationController?.navigationBar.backgroundColor = UIColor.clear
		self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 157/255, green: 181/255, blue: 171/255, alpha: 1)
	}


	
	// MARK: Core Data Fetch
	func fetchCategories() {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
		let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
		fetchRequest.sortDescriptors = [sortDescriptor]
		
//		let count = ad.managedObjectContext.countForFetchRequest(fetchRecipeRequest, error: nil)
		
		let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: ad.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
		fetchedResultsController = controller
		
		do {
			try self.fetchedResultsController?.performFetch()
			allCategories = fetchedResultsController?.fetchedObjects as! [Category]
		} catch {
			let error = error as NSError
			print("\(error), \(error.userInfo)")
		}
	}
	
	
	
	// MARK: TableView Code
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return allCategories.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
		if let category = fetchedResultsController?.object(at: indexPath) as? Category {
			cell.configureCell(category)
			cell.selectionStyle = UITableViewCellSelectionStyle.none
		}

		return CategoryCell()
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//UITableViewCellSelectionStyle.none
		let selectedCell: UITableViewCell = tableView.cellForRow(at: indexPath)!
		selectedCell.contentView.backgroundColor = UIColor(colorLiteralRed: 157/255, green: 181/255, blue: 178/255, alpha: 1)
		
		tableView.deselectRow(at: indexPath, animated: true)
		if let objs = fetchedResultsController?.fetchedObjects , objs.count > 0 {
			let item = objs[(indexPath as NSIndexPath).row] as! Category
			categorySelectionIndex = (indexPath as NSIndexPath).row

			performSegue(withIdentifier: "ShowListRecipes", sender: item)
		}
	}
	
	
	
	// MARK: NAVIGATION
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "ShowListRecipes" {
			let vc = segue.destination as! RecipesVC
			vc.categorySelectionIndex = categorySelectionIndex
		} else if segue.identifier == "ModalAddRecipe" {
			
		}
	}
	
}


