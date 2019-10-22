//
//  UserAccount.swift
//  Test4
//
//  Created by 山本裕太 on 2019/10/20.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation

struct UserData {
    
    private enum UserKeys: String {
        case userId = "user_id"
    }
    
    private init() {}
    
    private static let userDefaults = UserDefaults.standard
    
    static var userId: String? {
        get { return self.userDefaults.string(forKey: UserData.UserKeys.userId.rawValue) }
        set {
            self.userDefaults.set(newValue, forKey: UserData.UserKeys.userId.rawValue)
            self.userDefaults.synchronize()
        }
    }
    
    /// UserIdentifierを取得する(公開用)
    public static func getUserId() -> String {
        getOrSetUserIdentifier()
    }
    
    /// userIDが無ければuserIDを作成する。userIDが存在していればuserIDを作成する
    private static func getOrSetUserIdentifier() -> String {
        if let uid = UserData.userId {
            return uid
        }
        
        let newuid = UUID().uuidString
        UserData.userId = newuid
        return newuid
    }

}
