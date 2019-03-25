//
//  Item.swift
//  Todoo
//
//  Created by Apple on 24/03/2019.
//  Copyright © 2019 Gravico. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
