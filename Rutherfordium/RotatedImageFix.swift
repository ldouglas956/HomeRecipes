//
//  RotatedImageFix.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 6/9/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit

extension UIImage {
	
	func correctlyOrientedImage() -> UIImage {
		if self.imageOrientation == UIImageOrientation.Up {
			return self
		}
		
		UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
		self.drawInRect(CGRectMake(0, 0, self.size.width, self.size.height))
		let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		return normalizedImage;
	}
	
}
