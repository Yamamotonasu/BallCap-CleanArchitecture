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
    
    // 外側へデータの更新を通知するoutput
    var userOutput: UsersPresenterOutput? { get set }
}

// PresenterがViewへデータの変化を伝える時のインターフェース
protocol UsersPresenterOutput: class {
    // 表示用のデータが変化した事をPresenterからViewへ通知する
    func update(by viewDataArray: UserViewData)
}

final class UsersPresenter: UsersPresenterProtocol {
    
    private weak var useCase: UsersUseCaseProtocol!

    var userOutput: UsersPresenterOutput?
    
    init(useCase: UsersUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func createUser(name: String?, password: String?) {
        // UseCaseへ処理を依頼
        useCase.startCreateUser(name: name, password: password)
    }
    
    func fetchUser(identifier: String?) {
        // UseCaseへ処理を依頼
        useCase.startFetchUser(identifier: identifier)
    }

}
