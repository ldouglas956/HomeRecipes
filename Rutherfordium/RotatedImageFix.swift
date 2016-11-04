//
//  RotatedImageFix.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 6/9/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//
// Code thanks to StackExchange users: Gallymon and Brett
//

import UIKit
import Foundation

extension UIImage {
	
	func scaleAndRotateImageUsingOrientation() -> UIImage
	{
		//takes into account the stored rotation on the image fromt he camera and makes it upright
		let kMaxResolution = 3264 // Or whatever
		
		let imgRef    = self.cgImage
		let width     = imgRef?.width
		let height    = imgRef?.height
		var transform = CGAffineTransform.identity
		var bounds    = CGRect( x: 0.0, y: 0.0, width: CGFloat(width!), height: CGFloat(height!) )
		
		if ( width! > kMaxResolution || height! > kMaxResolution ) {
			let ratio : CGFloat = CGFloat(width!) / CGFloat(height!)
			
			if (ratio > 1) {
				bounds.size.width  = CGFloat(kMaxResolution)
				bounds.size.height = bounds.size.width / ratio
			} else {
				bounds.size.height = CGFloat(kMaxResolution)
				bounds.size.width  = bounds.size.height * ratio
			}
		}
		
		let scaleRatio : CGFloat = bounds.size.width / CGFloat(width!)
		let imageSize    = CGSize( width: CGFloat((imgRef?.width)!), height: CGFloat((imgRef?.height)!) )
		let orient       = self.imageOrientation
		var boundHeight : CGFloat = 0.0
		
		switch(orient) {
		case UIImageOrientation.up:                                        //EXIF = 1
			transform = CGAffineTransform.identity
			break
			
		case UIImageOrientation.upMirrored:                                //EXIF = 2
			transform = CGAffineTransform(translationX: imageSize.width, y: 0.0)
			transform = transform.scaledBy(x: -1.0, y: 1.0)
			break
			
		case UIImageOrientation.down:                                      //EXIF = 3
			transform = CGAffineTransform(translationX: imageSize.width, y: imageSize.height)
			transform = transform.rotated(by: CGFloat(M_PI))
			break
			
		case UIImageOrientation.downMirrored:                              //EXIF = 4
			transform = CGAffineTransform(translationX: 0.0, y: imageSize.height)
			transform = transform.scaledBy(x: 1.0, y: -1.0)
			break
			
		case UIImageOrientation.leftMirrored:                              //EXIF = 5
			boundHeight = bounds.size.height
			bounds.size.height = bounds.size.width
			bounds.size.width = boundHeight
			transform = CGAffineTransform(translationX: imageSize.height, y: imageSize.width)
			transform = transform.scaledBy(x: -1.0, y: 1.0)
			transform = transform.rotated(by: 3.0 * CGFloat(M_PI) / 2.0)
			break
			
		case UIImageOrientation.left:                                      //EXIF = 6
			boundHeight = bounds.size.height
			bounds.size.height = bounds.size.width
			bounds.size.width = boundHeight
			transform = CGAffineTransform(translationX: 0.0, y: imageSize.width)
			transform = transform.rotated(by: 3.0 * CGFloat(M_PI) / 2.0)
			break
			
		case UIImageOrientation.rightMirrored:                             //EXIF = 7
			boundHeight = bounds.size.height
			bounds.size.height = bounds.size.width
			bounds.size.width = boundHeight
			transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
			transform = transform.rotated(by: CGFloat(M_PI) / 2.0)
			break
			
		case UIImageOrientation.right:                                     //EXIF = 8
			boundHeight = bounds.size.height
			bounds.size.height = bounds.size.width
			bounds.size.width = boundHeight
			transform = CGAffineTransform(translationX: imageSize.height, y: 0.0)
			transform = transform.rotated(by: CGFloat(M_PI) / 2.0)
			break
		}
		
		UIGraphicsBeginImageContext( bounds.size )
		
		let context = UIGraphicsGetCurrentContext()
		
		if ( orient == UIImageOrientation.right || orient == UIImageOrientation.left ) {
			context?.scaleBy(x: -scaleRatio, y: scaleRatio)
			context?.translateBy(x: CGFloat(-height!), y: 0)
		} else {
			context?.scaleBy(x: scaleRatio, y: -scaleRatio)
			context?.translateBy(x: 0, y: CGFloat(-height!))
		}
		
		context?.concatenate(transform )
		
		UIGraphicsGetCurrentContext()?.draw(imgRef!, in: CGRect( x: 0, y: 0, width: CGFloat(width!), height: CGFloat(height!) ))
		let imageCopy = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return imageCopy!
	}

}
