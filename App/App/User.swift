//
//  User.swift
//  App
//
//  Created by student1 on 24/12/14.
//  Copyright (c) 2014 Hakan Uyumaz. All rights reserved.
//

import Foundation

class User {
    let id : Int
    let username : String
    let name : String
    let surname : String
    let email : String
    
    init(json : JSON) {
        id = json["id"].asInt!
        username = json["username"].asString!
        name = json["name"].asString!
        surname = json["surname"].asString!
        email = json["email"].asString!
    }
}