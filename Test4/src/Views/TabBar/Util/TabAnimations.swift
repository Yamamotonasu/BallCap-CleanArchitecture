//
//  TabAnimations.swift
//  Test4
//
//  Created by 山本裕太 on 2019/10/20.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import TransitionableTab

/// TransitionableTabのアニメーション定義
public enum MainTabBarAnimations {

    case move
    case fade
    case scale

    // MARK: - Functions

    func getBackAnimationWhenSelectedIndex(layer: CALayer?, direction: Direction) -> CAAnimation {
        switch self {
        case .move:
            return DefineAnimation.move(.from, direction: direction)
        case .scale:
            return DefineAnimation.scale(.from)
        case .fade:
            return DefineAnimation.fade(.from)
        }
    }

    func getForwardAnimationWhenSelectedIndex(layer: CALayer?, direction: Direction) -> CAAnimation {
        switch self {
        case .move:
            return DefineAnimation.move(.to, direction: direction)
        case .scale:
            return DefineAnimation.scale(.to)
        case .fade:
            return DefineAnimation.fade(.to)
        }
    }

}
