//
//  Category+CoreDataProperties.swift
//  Rutherfordium
//
//  Created by Lance Douglas on 6/6/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Category {

    @NSManaged var catPhoto: NSData?
    @NSManaged var title: String?
    @NSManaged var recipes: NSSet?

}
