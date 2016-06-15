//
//  CategoryCell.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 5/13/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit


class CategoryCell: UITableViewCell {
	
	@IBOutlet private weak var catTitle: UILabel!
	@IBOutlet private weak var catCount: UILabel!
	@IBOutlet private weak var catImage: UIImageView!
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	func configureCell(category: Category) {
		catTitle.text = category.title!.substringFromIndex(category.title!.startIndex.advancedBy(3))
		catImage.image = category.getCatImage()
		catCount.text = ""
	}

}
