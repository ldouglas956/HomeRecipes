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

extension UIImage {
	
	func scaleAndRotateImageUsingOrientation() -> UIImage
	{
		//takes into account the stored rotation on the image fromt he camera and makes it upright
		let kMaxResolution = 3264 // Or whatever
		
		let imgRef    = self.CGImage
		let width     = CGImageGetWidth(imgRef)
		let height    = CGImageGetHeight(imgRef)
		var transform = CGAffineTransformIdentity
		var bounds    = CGRectMake( 0.0, 0.0, CGFloat(width), CGFloat(height) )
		
		if ( width > kMaxResolution || height > kMaxResolution ) {
			let ratio : CGFloat = CGFloat(width) / CGFloat(height)
			
			if (ratio > 1) {
				bounds.size.width  = CGFloat(kMaxResolution)
				bounds.size.height = bounds.size.width / ratio
			} else {
				bounds.size.height = CGFloat(kMaxResolution)
				bounds.size.width  = bounds.size.height * ratio
			}
		}
		
		let scaleRatio : CGFloat = bounds.size.width / CGFloat(width)
		let imageSize    = CGSizeMake( CGFloat(CGImageGetWidth(imgRef)), CGFloat(CGImageGetHeight(imgRef)) )
		let orient       = self.imageOrientation
		var boundHeight : CGFloat = 0.0
		
		switch(orient) {
		case UIImageOrientation.Up:                                        //EXIF = 1
			transform = CGAffineTransformIdentity
			break
			
		case UIImageOrientation.UpMirrored:                                //EXIF = 2
			transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0)
			transform = CGAffineTransformScale(transform, -1.0, 1.0)
			break
			
		case UIImageOrientation.Down:                                      //EXIF = 3
			transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height)
			transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
			break
			
		case UIImageOrientation.DownMirrored:                              //EXIF = 4
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.height)
			transform = CGAffineTransformScale(transform, 1.0, -1.0)
			break
			
		case UIImageOrientation.LeftMirrored:                              //EXIF = 5
			boundHeight = bounds.size.height
			bounds.size.height = bounds.size.width
			bounds.size.width = boundHeight
			transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width)
			transform = CGAffineTransformScale(transform, -1.0, 1.0)
			transform = CGAffineTransformRotate(transform, 3.0 * CGFloat(M_PI) / 2.0)
			break
			
		case UIImageOrientation.Left:                                      //EXIF = 6
			boundHeight = bounds.size.height
			bounds.size.height = bounds.size.width
			bounds.size.width = boundHeight
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.width)
			transform = CGAffineTransformRotate(transform, 3.0 * CGFloat(M_PI) / 2.0)
			break
			
		case UIImageOrientation.RightMirrored:                             //EXIF = 7
			boundHeight = bounds.size.height
			bounds.size.height = bounds.size.width
			bounds.size.width = boundHeight
			transform = CGAffineTransformMakeScale(-1.0, 1.0)
			transform = CGAffineTransformRotate(transform, CGFloat(M_PI) / 2.0)
			break
			
		case UIImageOrientation.Right:                                     //EXIF = 8
			boundHeight = bounds.size.height
			bounds.size.height = bounds.size.width
			bounds.size.width = boundHeight
			transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0)
			transform = CGAffineTransformRotate(transform, CGFloat(M_PI) / 2.0)
			break
		}
		
		UIGraphicsBeginImageContext( bounds.size )
		
		let context = UIGraphicsGetCurrentContext()
		
		if ( orient == UIImageOrientation.Right || orient == UIImageOrientation.Left ) {
			CGContextScaleCTM(context, -scaleRatio, scaleRatio)
			CGContextTranslateCTM(context, CGFloat(-height), 0)
		} else {
			CGContextScaleCTM(context, scaleRatio, -scaleRatio)
			CGContextTranslateCTM(context, 0, CGFloat(-height))
		}
		
		CGContextConcatCTM( context, transform )
		
		CGContextDrawImage( UIGraphicsGetCurrentContext(), CGRectMake( 0, 0, CGFloat(width), CGFloat(height) ), imgRef )
		let imageCopy = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return imageCopy
	}

}
