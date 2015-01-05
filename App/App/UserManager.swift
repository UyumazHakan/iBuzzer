//
//  UserManager.swift
//  App
//
//  Created by student1 on 05/01/15.
//  Copyright (c) 2015 Hakan Uyumaz. All rights reserved.
//

import Foundation

private let _UserMangaerSharedInstance = UserManager()


class UserManager {
    var user : User?
    init() {
    }
    class var sharedInstance: UserManager {
        return _UserMangaerSharedInstance
    }
}