//
//  AppDelegate.swift
//  Test4
//
//  Created by 山本裕太 on 2019/10/19.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import Ballcap
import ReSwift

// アプリ全体で共通で利用するのでAppDelegateに定義する
let testStore = Store<TestAppState>(
    // アプリの利用するreducer
    reducer: counterReducer,
    // 初期のstatenil
    state: nil
)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var shared: AppDelegate {
        guard let app = UIApplication.shared.delegate as? AppDelegate else {
            exit(0)
        }
        return app
    }
    
    var window: UIWindow?

    override init() {
        super.init()
        FirebaseApp.configure()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Transition.transitionTabBar()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

}
