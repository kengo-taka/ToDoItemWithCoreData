//
//  ManagedToDoItem+CoreDataProperties.swift
//  ToDoListWithCoreData
//
//  Created by Takamiya Kengo on 2021/02/25.
//
//

import Foundation
import CoreData


extension ManagedToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedToDoItem> {
        return NSFetchRequest<ManagedToDoItem>(entityName: "ManagedToDoItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: String?
    @NSManaged public var priority: String?

}

extension ManagedToDoItem : Identifiable {

}
