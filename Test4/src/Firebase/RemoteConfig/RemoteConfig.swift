//
//  RemoteConfig.swift
//  Test4
//
//  Created by 山本裕太 on 2019/11/21.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation
import Firebase

/**
 * Define RemoteConfgParameters
 *  - RemoteConfigKeysを参照した時に自動的にremote configから値をfetchしてくる。
 */
enum RemoteConfigKeys {

    // collection view用のjson
    case testJsonForCollection
    // table view用のjson
    case testJsonForTable
    
    private var key: String {
        switch self {
        case .testJsonForTable:
            return "test_json_for_table"
        case .testJsonForCollection:
            return "test_json_for_collection"
        }
    }
    
    static let activate = ActivateRemoteConfig()
    
    // remote configを外部から参照する為の公開用変数
    var value: RemoteConfigValue? {
        return RemoteConfigKeys.activate.remoteConfig.configValue(forKey: self.key)
    }
    
    var stringValue: String? {
        return self.value?.stringValue
    }
    
    var numberValue: NSNumber? {
        return self.value?.numberValue
    }
    
    var boolValue: Bool {
        return self.value?.boolValue ?? false
    }

}

final class ActivateRemoteConfig {
    
    let remoteConfig: RemoteConfig
    
    private let settings: RemoteConfigSettings
    
    private let expirationDuration: Double
    
    init() {
        self.remoteConfig = RemoteConfig.remoteConfig()
        self.settings = RemoteConfigSettings()
        expirationDuration = 20
        self.fetchRemoteConfigParemeters()
    }
    
    private func fetchRemoteConfigParemeters() {
        remoteConfig.fetch(withExpirationDuration: expirationDuration) { [weak self] status, error -> Void in
            guard let _self = self else { return }
            if status == .success {
                _self.remoteConfig.activate { error in
                    if let e = error {
                        print("**\(e.localizedDescription)")
                        return
                    }
                }
            } else {
                print("**Config not fetched")
                print("**Error: \(error?.localizedDescription ?? "not available")")
            }
        }
    }
    
    private func settingRemoteConfig() {
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }

}


