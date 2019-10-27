//
//  Action.swift
//  Test4
//
//  Created by 山本裕太 on 2019/10/27.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation
import ReSwift

/**
 * Actions
 *  - Reducerへの橋渡し
 *  - 全てActionProtocolへ準拠する必要がある
 *  - enum又はstructで定義する
 */

struct CounterActionIncrease: Action {}
struct CounterActionDecrease: Action {}
