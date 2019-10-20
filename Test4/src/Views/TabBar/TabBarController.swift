//
//  TabBarController.swift
//  Test4
//
//  Created by 山本裕太 on 2019/10/20.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import FontAwesome
import TransitionableTab

/// Mainで表示するTabBarのclass
class TabBarController: UITabBarController {
    
    private static let selectedTabBarAnimations: MainTabBarAnimations = .move

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainTabBarInitialSetting()
        setupMainTabBarContents()
    }
    
    /// tabを選択した時に呼ばれる(animation処理等)
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // UITabBarControllerに配置されているアイコン画像をアニメーションさせる為の処理
        // 現在配置されているUITabBarからUIImageViewを取得して配列にして取得する
        let targetClass: AnyClass = NSClassFromString("UITabBarButton")!
        // TODO: Animation処理 swift5.1で動作しないので要調査
        let tabBarImageViews = tabBar.subviews
            .filter{ $0.isKind(of: targetClass) }
            .map{ $0.subviews.first! }
        executeBounceAnimationFor(selectedImageView: tabBarImageViews[item.tag])
    }
    
    // MARK: - Private Functions
    
    /// UITabBarControllerの初期設定に関する調整
    private func setupMainTabBarInitialSetting() {
        
        self.delegate = self
        
        // 初期設定として空のViewControllerを入れておく
        self.viewControllers = [UIViewController(), UIViewController(), UIViewController()]
    }
    
    /// TabBarControllerで表示したい画面に関する設定処理
    private func setupMainTabBarContents() {
        // タブの選択時・非選択時の色とアイコンのサイズを決める
        let itemSize = CGSize(width: 28.0, height: 28.0)
        let normalColor: UIColor = UIColor(code: "#bcbcbc")
        let selectedColor: UIColor = UIColor(code: "#696969")
        let tabBarItemFont = UIFont(name: "HiraKakuProN-W6", size: 10)!
        
        // TabBar用のAttributeを決める
        let normalAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: tabBarItemFont,
            NSAttributedString.Key.foregroundColor: normalColor
        ]
        let selectedAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: tabBarItemFont,
            NSAttributedString.Key.foregroundColor: selectedColor
        ]
        
        // TabBarに表示する画面を決める
        let _ = TabBarItems.allCases.enumerated().map { (index, item) in
            
            // 該当ViewControllerの設置
            guard let vc = item.getViewController() else {
                fatalError()
            }
            self.viewControllers?[index] = vc
            
            // 該当ViewControllerのタイトル設置
            self.viewControllers?[index].title = item.getTitle()
            
            // 該当ViewControllerのタブバー要素設置
            self.viewControllers?[index].tabBarItem.tag = index
            self.viewControllers?[index].tabBarItem.setTitleTextAttributes(normalAttributes, for: [])
            self.viewControllers?[index].tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
            self.viewControllers?[index].tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -1.5)
            self.viewControllers?[index].tabBarItem.image = UIImage.fontAwesomeIcon(name: item.getFontAwesomIcon(), style: .solid, textColor: normalColor, size: itemSize).withRenderingMode(.alwaysOriginal)
            self.viewControllers?[index].tabBarItem.selectedImage = UIImage.fontAwesomeIcon(name: item.getFontAwesomIcon(), style: .solid, textColor: selectedColor, size: itemSize).withRenderingMode(.alwaysOriginal)
        }
    }
    
    /// 該当のUIImageViewに対してバウンドするアニメーションを実行する
    /// アニメーション自体は0.16秒間隔で実行され割り込みを許可する
    private func executeBounceAnimationFor(selectedImageView: UIView) {
        UIView.animateKeyframes(withDuration: 0.16, delay: 0.0, options: [.allowUserInteraction, .autoreverse], animations: {

            // 全体のアニメーション時間の中のどの地点からアニメーションを開始するかを0.0〜1.0の間で指定する
            // 参考: iOSアプリ開発でアニメーションするなら押さえておきたい基礎
            // https://qiita.com/hachinobu/items/57d4c305c907805b4a53
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0, animations: {
                selectedImageView.transform = CGAffineTransform(scaleX: 1.14, y: 1.14)
            })
            UIView.addKeyframe(withRelativeStartTime: 1.0, relativeDuration: 1.0, animations: {
                selectedImageView.transform = CGAffineTransform.identity
            })
        })
    }

}

// MARK: - TransitionableTab

extension TabBarController: TransitionableTab {
    
}

// MARK: - MakeInstance

extension TabBarController {
    
    static func makeInstance() -> UITabBarController {
        guard let tvc = R.storyboard.tabBar.tabBarController() else {
            return TabBarController()
        }
        return tvc
    }
    
}
