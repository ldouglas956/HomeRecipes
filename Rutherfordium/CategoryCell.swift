//
//  CategoryCell.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 5/13/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit


class CategoryCell: UITableViewCell {
	
	@IBOutlet fileprivate weak var catTitle: UILabel!
	@IBOutlet fileprivate weak var catCount: UILabel!
	@IBOutlet fileprivate weak var catImage: UIImageView!
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	func configureCell(_ category: Category) {
		catTitle.text = category.title!.substring(from: category.title!.characters.index(category.title!.startIndex, offsetBy: 3))
		catImage.image = category.getCatImage()
		catCount.text = ""
	}
	
}
