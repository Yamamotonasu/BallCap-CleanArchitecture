//
//  Result.swift
//  Test4
//
//  Created by 山本裕太 on 2019/10/22.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
