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
    // create user
    func startCreateUser(name: String?, password: String?)
    // fetch user
    func startFetchUser(identifier: String?)
}

protocol UsersGatewayProtocol {
    func create(name: String?, password: String?, completion: @escaping () -> Void)
    func fetch(identifier: String?, completion: @escaping () -> Void)
}

// UseCaseの実装
final class UsersUseCase: UsersUseCaseProtocol {
    
    func startCreateUser(name: String?, password: String?) {
        // <#code#>
    }
    
    func startFetchUser(identifier: String?) {
        // <#code#>
    }
}




