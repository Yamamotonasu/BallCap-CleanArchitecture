//
//  TestTwoViewController.swift
//  Test4
//
//  Created by 山本裕太 on 2019/10/20.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import ReSwift
import RxSwift
import RxCocoa

/**
 * StoreSubscriberに準拠させる
 *  viewDidLoadでAppDelegateで作成したStoreをsubscribeさせる
 *  newStateを定義し新しいStateを元にUIを更新する
 */
class TestTwoViewController: UIViewController, StoreSubscriber {

    @IBOutlet weak var countLabel: UILabel!

    @IBOutlet weak var upButton: UIButton!

    @IBOutlet weak var downButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        testStore.subscribe(self)
        subscribe()
    }

    func newState(state: TestAppState) {
        countLabel.text = "\(testStore.state.counter)"
    }

}

extension TestTwoViewController {

    private func subscribe() {
        upButton.rx.tap.subscribe(onNext: { _ in
            testStore.dispatch(CounterActionIncrease())
        }).disposed(by: rx.disposeBag)

        downButton.rx.tap.subscribe(onNext: { _ in
            testStore.dispatch(CounterActionDecrease())
        }).disposed(by: rx.disposeBag)
    }

}
