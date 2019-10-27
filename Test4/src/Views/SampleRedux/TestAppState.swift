//
//  TestAppState.swift
//  Test4
//
//  Created by 山本裕太 on 2019/10/27.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation
import ReSwift

/**
 * State
 *  - structで定義しstateTypeプロトコルに準拠して定義する
 *
 */
struct TestAppState: StateType {
    var counter: Int = 0
}
