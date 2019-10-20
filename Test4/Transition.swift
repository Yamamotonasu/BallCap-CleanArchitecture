//
//  Transition.swift
//  Test4
//
//  Created by 山本裕太 on 2019/10/20.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation
import UIKit

public struct Transition {
    
    static func transitionTabBar() {
        let tab = TabBarController.makeInstance()

        let app = AppDelegate.shared

        // もしまだviewControllerのインスタンスが作成されていない時
        if app.window == nil {
            app.window = UIWindow(frame: UIScreen.main.bounds)
        }
        app.window?.rootViewController = tab
        app.window?.makeKeyAndVisible()
    }

}
