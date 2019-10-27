//
//  Reducer.swift
//  Test4
//
//  Created by 山本裕太 on 2019/10/27.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation
import ReSwift

/**
 * Reducer
 * - 一旦関数直書き
 * - ActionとStateを受け取り新しいStateを返却する
 * - Reducer以外でStateの状態を変更する事はない
 */

func counterReducer(action: Action, state: TestAppState?) -> TestAppState {
    // stateは存在しない可能性もあるので考慮する必要がある。
    var state = state ?? TestAppState()
    switch action {
    case is CounterActionIncrease:
        state.counter += 1
    case is CounterActionDecrease:
        state.counter -= 1
    default:
        break
    }
    return state
}
