//
//  Array+Extended.swift
//  Test4
//
//  Created by 山本裕太 on 2019/10/22.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation

public enum UniqueStrategy {
    case ignoreNewOne
    case replaceByNewOne
    case removeOldOne
}
public extension Array where Element: Equatable {
    func unique(resolve: (Element, Element) -> UniqueStrategy) -> [Element] {
        return reduce(into: []) { (result, newOne) in
            switch result.firstIndex(of: newOne) {
            case .none:
                result.append(newOne)
            case let prevIndex?:
                let prev = result[prevIndex]
                switch resolve(prev, newOne) {
                case .ignoreNewOne:
                    ()
                case .replaceByNewOne:
                    result[prevIndex] = newOne
                case .removeOldOne:
                    result.remove(at: prevIndex)
                    result.append(newOne)
                }
            }
        }
    }
}
