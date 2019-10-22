//
//  Firestore+Users.swift
//  Test4
//
//  Created by 山本裕太 on 2019/10/22.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Ballcap

// Firebaseとの通信が成功したかどうかの可否をGatewayに返す
struct UsersCommunications: UsersCommunicationsProtocol {
    
    let document: Document<User>

    func create(name: String?, password: String?, completion: @escaping () -> Void) {
        guard let name = name, let password = password else { return }
        document.data?.name = name
        document.data?.password = password
        document.save { error in
            if let error = error {
                print("** \(error.localizedDescription)")
            }
        }
    }
    
    func fetch(identifier: String?) {
        // <#code#>
    }
    
    
}
