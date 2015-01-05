//
//  Menu.swift
//  App
//
//  Created by student1 on 05/01/15.
//  Copyright (c) 2015 Hakan Uyumaz. All rights reserved.
//

import Foundation


class Menu {
    var items = [Item]()
    init(json:JSON) {
        var jsonList = json.asArray!
        for jsonElement in jsonList {
            items.append(Item(json: jsonElement))
        }
    }
}

class Item {
    var name : String
    var price : String
    init(json : JSON) {
        name = json["NAME"].asString!
        price = json["PRICE"].asString!
    }
}