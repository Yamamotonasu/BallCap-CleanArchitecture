//
//  UsersPresenter.swift
//  Test4
//
//  Created by 山本裕太 on 2019/10/22.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation

/**
 * - UIからユーザーを作成する関数の呼び出しを受け取り、UseCaseへ伝える
 * - UseCaseからの関節的な呼び出しによるUserのデータの取得を行う
 * - → 呼び出したデータを元にしてViewに表示するユーザーデータを加工してViewへ渡す
 */

// ビューへ表示するデータ
struct UserViewData {
    let name: String
    let password: String
    let identifier: String
}

// PresenterがViewへ公開するインターフェース
protocol UsersPresenterProtocol: AnyObject {
    // create user
    func createUser(name: String?, password: String?)
    // fetch user
    func fetchUser(identifier: String?)
}

// 
