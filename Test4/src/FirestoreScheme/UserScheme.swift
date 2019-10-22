//
//  UserModel.swift
//  Test4
//
//  Created by 山本裕太 on 2019/10/20.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Ballcap

struct User: Codable, Equatable, Modelable {

    var userId: String = UserData.getUserId()
    var name: String = " "
    var password: String = " "
    var createdAt: ServerTimestamp?
    var updatedAt: ServerTimestamp?

}
