//
//  Restaurant.swift
//  App
//
//  Created by student1 on 05/01/15.
//  Copyright (c) 2015 Hakan Uyumaz. All rights reserved.
//

import Foundation

class Restaurant {
    let id: Int
    let name: String
    let type: String
    
    init(json: JSON){
        id = json["ID"].asInt!
        name = json["NAME"].asString!
        type = json["TYPE"].asString!
        println("Restauran Created: " + name + ", " + type )
    }
}