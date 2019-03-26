//
//  Category.swift
//  Todoo
//
//  Created by Apple on 24/03/2019.
//  Copyright © 2019 Gravico. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var colour: String = ""
    let items = List<Item>()
}
