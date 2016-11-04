//
//  SampleRecipes.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 6/7/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//
//  Template Recipes used from AllRecipes.com with links included to source website.
//

import UIKit
import CoreData

class SampleRecipes {
	
	// MARK: TEST DATA
	
	// 1) Appetizers
	// 2) Soup / Chili
	// 3) Salad
	// 4) Main Course
	// 5) Sides
	// 6) Dessert
	// 7) Breakfast
	// 8) Snacks
	// 9) Drinks
	
	func generateTestData(_ allCategories: [Category]) {
		
		// 1) Appetizers
		let recipe1 = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: ad.managedObjectContext) as! Recipe
		recipe1.name = "Stuffed Mushrooms"
		recipe1.setRecipeImage(UIImage(named: "mushrooms")!)
		recipe1.category = allCategories[0]
		recipe1.servings = 12
		recipe1.time = 45
		recipe1.ingredients = "-12 whole fresh mushrooms\n-1 tbsp vegetable oil\n-1 tbsp minced garlic\n-1 8oz package cream cheese\n-1/4 cup grated parmesan cheese\n-1/4 tsp black pepper\n-1/4 tsp onion powder\n-1/4 tsp cayenne pepper"
		recipe1.directions = "-Preheat oven to 350 degrees F (175 degrees C). Spray a baking sheet with cooking spray. Clean mushrooms with a damp paper towel. Carefully break off stems. Chop stems extremely fine, discarding tough end of stems.\n-Heat oil in a large skillet over medium heat. Add garlic and chopped mushroom stems to the skillet. Fry until any moisture has disappeared, taking care not to burn garlic. Set aside to cool.\n-When garlic and mushroom mixture is no longer hot, stir in cream cheese, Parmesan cheese, black pepper, onion powder and cayenne pepper. Mixture should be very thick. Using a little spoon, fill each mushroom cap with a generous amount of stuffing. Arrange the mushroom caps on prepared cookie sheet.\n-Bake for 20 minutes in the preheated oven, or until the mushrooms are piping hot and liquid starts to form under caps."
		recipe1.link = "http://allrecipes.com/recipe/15184/mouth-watering-stuffed-mushrooms/?internalSource=staff%20pick&referringId=76&referringContentType=recipe%20hub"
		
		// 2) Soup / Chili
		let recipe2 = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: ad.managedObjectContext) as! Recipe
		recipe2.name = "Chicken Noodle Soup"
		recipe2.setRecipeImage(UIImage(named: "chickenSoup")!)
		recipe2.category = allCategories[1]
		recipe2.servings = 8
		recipe2.time = 90
		recipe2.ingredients = "-4 lb chicken\n-4 cups chicken broth\n-5 cups water\n-coarse salt and fresh pepper\n-2 medium yellow onions thinly sliced\n-4 crushed garlic cloves\n-4 medium carrots sliced diagonally\n-2 sliced celery stalks\n-12 sprigs flat-leaf parsley\n-2 oz angel hair pasta"
		recipe2.directions = "-In a stockpot, combine chicken, broth, the water, and 1 teaspoon salt. Bring to a boil, skimming off foam from surface with a large spoon. Reduce heat to medium-low, and simmer 5 minutes, skimming frequently. Add onions, garlic, carrots, celery, and parsley. Simmer, partially covered, until chicken is cooked through, about 25 minutes.\n-Remove parsley and chicken, discarding back, neck, and parsley. Let cool, then tear meat into bite-size pieces. Skim fat.\n-Return broth to a boil and add pasta; simmer 5 minutes. Stir in 3 cups chicken (reserve remaining chicken for another use).\n-Season soup with salt and pepper. Garnish with chopped parsley before serving."
		recipe2.link = "http://www.marthastewart.com/1085620/one-pot-classic-chicken-noodle-soup"
		
		// 3) Salad
		let recipe3 = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: ad.managedObjectContext) as! Recipe
		recipe3.name = "Basil Pesto Pasta Salad"
		recipe3.setRecipeImage(UIImage(named: "pastaSalad")!)
		recipe3.category = allCategories[2]
		recipe3.servings = 4
		recipe3.time = 20
		recipe3.ingredients = "-1 medium head of broccoli, chopped\n-half a head of cauliflower (or 2-3 cups)\n-3 organic carrots, chopped\n-1 red bell pepper, chopped\n-3 cloves of garlic\n-1/2 cup of pine nuts\n-2 cups of fresh basil leaves, washed and stems removed\n-4 TBSP lemon juice\n-dash of kosher salt\n-2 TBSP of olive oil\n-pinch of freshly ground black pepper\n-1-2 (12 oz.) boxes of gluten free fusilli pasta (Jovial is the brand I used from Whole Foods)"
		recipe3.directions = "-Cook pasta according to package directions until al dente. While pasta is cooking, mix the pine nuts, basil, lemon juice, salt, pepper, and olive oil in a food processor or a high powered blender, and puree until smooth.\n-Place vegetables in a large mixing bowl and set aside.\n-Drain pasta and pour hot pasta water over vegetables. Blanch vegetables in pasta water for 3 minutes. Drain blanched vegetables, add cooked pasta and approximately 2 TBS of the pesto sauce and toss gently until mixed.\n-Refrigerate for 2-3 hours for flavors to marinate."
		recipe3.link = "https://holdthecheeseplease.com/2016/06/18/basil-pesto-pasta-salad/"
		
		// 4) Main Course
		let recipe4 = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: ad.managedObjectContext) as! Recipe
		recipe4.name = "Creamy Spinach Sweet Potato Noodles with Cashew Garlic Sauce"
		recipe4.setRecipeImage(UIImage(named: "noodles")!)
		recipe4.category = allCategories[3]
		recipe4.servings = 6
		recipe4.time = 30
		recipe4.ingredients = "-1 cup cashews\n-3/4 cup water\n-1/2 Tsp salt\n-1 clove of garlic\n-1 TBS olive oil\n-4 large sweet potatoes, spiralized\n-2 cups of baby spinach\n-a handful of fresh basil leaves, chives, or other herbs\n-grilled chicken (optional, but recommended)\n-1 15 0z. can of chickpeas\n-salt and pepper to taste\n-olive oil for drizzling grated Boar’s Head Gouda Cheese on top (lactose free or you could use regular parmesan or dairy free Go Veggie Parmesan)"
		recipe4.directions = "-Cover the cashews with water in a bowl and soak for 2 hours or so.\n-Drain and rinse thoroughly. Place in a food processor, I did mine in a VitaMix, and add the 3/4 cup water, salt, and garlic. Blend until very smooth.\n-Heat the oil in a large skillet over high heat. Add the sweet potatoes; toss in the pan for 6-7 minutes with tongs until tender crisp. Reduce heat and add in spinach – it should wilt pretty quickly.  Also add in chickpeas. Let cook for another 6-7 minutes./n-Add all the herbs and half of the sauce to the pan and toss to combine. Add water if the mixture is too sticky. Season generously with salt and pepper, drizzle with olive oil and top with the remaining fresh herbs.\n-If you made grilled chicken or bacon, which I recommend chicken, add it on top at the end and stir. "
		recipe4.link = "https://holdthecheeseplease.com/2016/03/03/creamy-spinach-sweet-potato-noodles-with-cashew-garlic-sauce/"
		
		// 5) Sides
		let recipe5 = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: ad.managedObjectContext) as! Recipe
		recipe5.name = "Baked Macaroni"
		recipe5.setRecipeImage(UIImage(named: "macaroni")!)
		recipe5.category = allCategories[4]
		recipe5.servings = 8
		recipe5.time = 60
		recipe5.ingredients = "-4 cup grated cheddar\n-1 can cream of mushroom soup\n-3/4 cup mayonaise\n-1/2 cup chopped onion\n-1 jar pimiento peppers\n-2 cup elbow macaroni\n-2 cup cheese crackers"
		recipe5.directions = "-Preheat oven to 350 degrees F. Meanwhile, butter a 9- by 13-inch baking dish and set aside.\n-In a large bowl, combine Cheddar, soup, mayonnaise, onion, and pimientos. Add cooked macaroni; combine.\n-Transfer macaroni mixture to prepared baking dish. Layer crackers evenly atop casserole. Bake until cheese is bubbly and top of casserole is lightly toasted, about 40 minutes."
		recipe5.link = "http://www.countryliving.com/food-drinks/recipes/a5098/baked-macaroni-recipe-clx0514/"
		
		// 6) Dessert
		let recipe6 = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: ad.managedObjectContext) as! Recipe
		recipe6.name = "Chocolate Chip Cookies"
		recipe6.setRecipeImage(UIImage(named: "cookie")!)
		recipe6.category = allCategories[5]
		recipe6.servings = 48
		recipe6.time = 45
		recipe6.ingredients = "-3/4 cup sugar\n-3/4 cup brown sugar\n-1 cup butter or margarine\n-1 tsp vanilla\n-1 egg\n-2 1/4 cup all-purpose flour\n-1 tsp baking soda\n-1/2 tsp salt\n-1 cup coarsely chopped nuts\n-1 package (12 oz or 2 cups) semisweet chocolate chips"
		recipe6.directions = "-Heat oven to 375 F\n-Mix sugar, butter, vanilla, and egg in a large bowl.  Stir in flour, baking soda, and salt.  Stir in nuts and chocolate chips\n-Drop tough by rounded tabelspoonfuls about 2 inches apart onto ungreased cookie sheet\n-Bake 8 to 10 minutes or until light brown.  Cool slightly; remove from cookie sheet.  Cool on wire rack"
		recipe6.link = "http://www.bettycrocker.com/recipes/ultimate-chocolate-chip-cookies/77c14e03-d8b0-4844-846d-f19304f61c57"
		
		// 7) Breakfast
		let recipe7 = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: ad.managedObjectContext) as! Recipe
		recipe7.name = "Flag Toast"
		recipe7.setRecipeImage(UIImage(named: "toast")!)
		recipe7.category = allCategories[6]
		recipe7.servings = 4
		recipe7.time = 10
		recipe7.ingredients = "-1 Cup Blueberries\n-4 Thick Slices Broche\n-1 4-oz Package Cream Cheese\n-4 Tsp Strawberry Jam\n-1 Sliced Banana"
		recipe7.directions = "-Toast slices of bread.  Spread each piece of toast with 2 tablespoons cream cheese.  Spread 1 teaspoon strawberry jam over the cream cheese except the upper left quarter.\n-Make 3 rows of 3 blueberries each in the upper left quarter, creating 'stars.' Make 3 rows of banana pieces, starting adjacent to the middle row of berries. Place the remaining 2 rows beneath the last row of berries, creating the 'stripes.'"
		recipe7.link = "http://allrecipes.com/recipe/242404/red-white-and-blue-flag-toast/?internalSource=rotd&referringId=78&referringContentType=recipe%20hub"
		
		// 8) Snacks
		let recipe8 = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: ad.managedObjectContext) as! Recipe
		recipe8.name = "Trail Mix"
		recipe8.setRecipeImage(UIImage(named: "trailMix")!)
		recipe8.category = allCategories[7]
		recipe8.servings = 2
		recipe8.time = 5
		recipe8.ingredients = "-1/2 cup cashews\n-1/4 cup peanuts\n-1/4 cup almonds\n-1/2 cup raisins\n-1 package M&Ms or similar chocolate candy"
		recipe8.directions = "-Combine in a bown and store in an airtight container"
		recipe8.link = "http://www.cheatsheet.com/culture/5-healthy-homemade-trail-mix-recipes-that-go-the-distance.html/?a=viewall"
		
		// 9) Drinks
		let recipe9 = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: ad.managedObjectContext) as! Recipe
		recipe9.name = "Irish Coffee"
		recipe9.setRecipeImage(UIImage(named: "coffee")!)
		recipe9.category = allCategories[8]
		recipe9.servings = 1
		recipe9.time = 5
		recipe9.ingredients = "-1.5 oz jigger Irish cream\n-1.5 oz jigger Irish whiskey\n-1 cup hot brewed coffee\n-1 tbsp whipping cream\n-1 dash ground nutmeg"
		recipe9.directions = "-Combine Irish cream, Irish whiskey and coffee in a coffee mug.\n-Top with whipped cream and add a dash of nutmeg"
		recipe9.link = "http://allrecipes.com/recipe/44045/irish-coffee/?internalSource=staff%20pick&referringId=134&referringContentType=recipe%20hub"
		
		ad.saveContext()
	}
	
	
}
