//
//  CategoryEntity.swift
//  ToDoey
//
//  Created by Roy Quesada on 10/6/23.
//

import Foundation
import RealmSwift

class CategoryEntity: Object {
    @objc dynamic var name:String = ""
    let items = List<Item>()
}
