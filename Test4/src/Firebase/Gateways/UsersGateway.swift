//
//  UsersGateway.swift
//  Test4
//
//  Created by 山本裕太 on 2019/10/22.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation
import Ballcap

protocol UsersCommunicationsProtocol {
    func create(name: String?, password: String?, completion: @escaping () -> Void)
    func fetch(identifier: String?)
}

/**
 * 通信を開始する事をCommunicationsへ伝える
 * →success又はerrorを受け取る
 * →キャッシュとして保存し、外側へ処理を伝える
 */
struct UsersGateway: UsersGatewayProtocol {
    
    var communication: UsersCommunicationsProtocol!

    func create(name: String?, password: String?, completion: @escaping () -> Void) {
        communication.create(name: name, password: password) {
            // memo: 未実装
        }
    }
    
    func fetch(identifier: String?, completion: @escaping () -> Void) {
        // <#code#>
    }
    
    
}
