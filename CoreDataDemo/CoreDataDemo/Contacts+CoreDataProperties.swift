//
//  Contacts+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Kerolos Nakhla on 11/24/15.
//  Copyright © 2015 Kerolos Nakhla. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Contacts {

    @NSManaged var name: String?
    @NSManaged var phone: String?
    @NSManaged var address: String?

}
