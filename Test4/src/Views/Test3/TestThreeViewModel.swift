//
//  TestThreeViewModel.swift
//  Test4
//
//  Created by 山本裕太 on 2019/11/03.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

protocol TestThreeViewModelProtocol {
    func updateItems()
}

class TestThreeViewModel: TestThreeViewModelProtocol {
    
    // 非公開
    private let items = BehaviorRelay<[SettingsSectionModel]>(value: [])
    
    // BehaviorRelay→Observableへ変換してViewControllerへ公開
    var itemsObservable: Observable<[SettingsSectionModel]> {
        return items.asObservable()
    }
    
    func setup() {
        updateItems()
    }
    
    internal func updateItems() {
        let sections: [SettingsSectionModel] = [
            accountSection(),
            commonSection()
        ]
        // Relayを更新
        items.accept(sections)
    }
    
    private func accountSection() -> SettingsSectionModel {
        let items: [SettingsItem] = [
            .account,
            .security,
            .notification,
            .contents
        ]
        return SettingsSectionModel(model: .account, items: items)
    }
    
    private func commonSection() -> SettingsSectionModel {
        let items: [SettingsItem] = [
            .sounds,
            .dataUsing,
            .accessibility,
            .description(text: "基本設定はこの端末でログインしている全てのアカウントに適用されます。")
        ]
        return SettingsSectionModel(model: .common, items: items)
    }
}
