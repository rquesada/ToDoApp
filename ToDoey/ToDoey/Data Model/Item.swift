//
//  Item.swift
//  ToDoey
//
//  Created by Roy Quesada on 10/6/23.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title:String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    let parentCategory = LinkingObjects(fromType: CategoryEntity.self, property: "items")
}
