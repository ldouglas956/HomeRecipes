//
//  UINavController.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 6/10/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit

class CustomUINavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//		viewSetUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	func viewSetUp() {
		self.navigationBar.backgroundColor = UIColor.lightGrayColor()
		self.navigationItem.titleView = UIImageView(image: UIImage(named: "Home-Recipes"))
	}

}
