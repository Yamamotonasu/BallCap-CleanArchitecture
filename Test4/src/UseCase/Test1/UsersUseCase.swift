//
//  UsersUseCase.swift
//  Test4
//
//  Created by 山本裕太 on 2019/10/22.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation

// UserCaseがInterfaceAdapterへ公開するインターフェース
protocol UsersUseCaseProtocol: AnyObject {
    // ユーザーを作成する
    func createUser(name: String?, password: String?)
    // ユーザーを取得する
    func fetchUser(identifier: String?)

}


