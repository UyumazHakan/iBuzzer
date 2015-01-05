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
        id = json["ID"].asInt!
        username = json["USERNAME"].asString!
        name = json["NAME"].asString!
        surname = json["SURNAME"].asString!
        email = json["EMAIL"].asString!
    }
}