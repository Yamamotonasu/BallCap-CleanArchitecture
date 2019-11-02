//
//  TestThreeViewController.swift
//  Test4
//
//  Created by 山本裕太 on 2019/10/20.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

/**
 * RxSwift Cocoa 振る舞い確認用
 */
class TestThreeViewController: UIViewController {
    
    var viewModel: CounterViewModelProtocol!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!
    
    // view model
    
    @IBOutlet weak var incrementButton: UIButton!
    
    @IBOutlet weak var decrementButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var goWebView: UIButton!
    
    
    static let characterLimit: Int = 50
    
    let sampleText = "yaa"
    
    let subject = PublishSubject<String>()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        goWebView.rx.tap.subscribe(onNext: { [weak self] in
            let vc = WebViewViewController.instance()
            self?.present(vc, animated: true)
        }).disposed(by: rx.disposeBag)
    }
    
    private func setupViewModel() {
        viewModel = CounterViewModel()
        // ①tap時のObservableをViewModelへ渡す
        let input = CounterViewModelInput(
            countUpButton: incrementButton.rx.tap.asObservable(),
            countDownButton: decrementButton.rx.tap.asObservable(),
            countResetButton: resetButton.rx.tap.asObservable()
        )
        
        viewModel.setup(input: input)
        
        viewModel.outputs?.counterText
            .drive(textLabel.rx.text)
            .disposed(by: rx.disposeBag)
    }

}

extension TestThreeViewController {
    
    // ラベルと入力テキストの値を接続させる
    private func subscribeUI1() {
        textField.rx.text
            .bind(to: textLabel.rx.text)
            .disposed(by: rx.disposeBag)
    }
    // 上と同じ振る舞いをする
    private func subscribeUI2() {
        textField.rx.text.subscribe(onNext: { [weak self] text in
            self?.textLabel.text = text
        }).disposed(by: rx.disposeBag)
    }

}

/**
 * map
 */
extension TestThreeViewController {
    
    private func subscribeUI3() {
        textField.rx.text.map { text -> String? in
            // mapは必ず加工した値をreturnする必要がある
            // guard句でもreturnでnilを返す
            guard let text = text else { return nil }
            let remainingCharacters = TestThreeViewController.characterLimit - text.count
            return remainingCharacters > 0 ? "あと\(remainingCharacters)文字" : "もうこれ以上入力出来ません。"
        }
        .bind(to: textLabel.rx.text)
        .disposed(by: rx.disposeBag)
    }
    
    private func myjust<E>(_ element: E) -> Observable<E> {
        return Observable.create { observer -> Disposable in
            observer.on(.next(element))
            observer.on(.completed)
            return Disposables.create()
        }
    }
    
}

// MARK: - CountupApp

struct CounterViewModelInput {
    let countUpButton: Observable<Void>
    let countDownButton: Observable<Void>
    let countResetButton: Observable<Void>
}

protocol CounterViewModelOutput {
    var counterText: Driver<String?> { get }
}

protocol CounterViewModelProtocol: class {
    var outputs: CounterViewModelOutput? { get }
    func setup(input: CounterViewModelInput)
}

class CounterViewModel: CounterViewModelProtocol {
    
    var outputs: CounterViewModelOutput?
    
    // 初期値が0(非公開用)
    private let counterRelay = BehaviorRelay<Int>(value: 0)
    
    private let initialCount = 0
    
    init() {
        // viewModelをprotocolに準拠させないとselfを代入出来ない
        self.outputs = self
        // 初期値を設定
        reset()
    }
    
    // ②Observableをsubscribeしてtapイベントを検知する
    func setup(input: CounterViewModelInput) {
        input.countUpButton.subscribe(onNext: { [weak self] in
            self?.incremenet()
        }).disposed(by: DisposeBag())
        
        input.countDownButton.subscribe(onNext: { [weak self] in
            self?.decrement()
        }).disposed(by: DisposeBag())
        
        input.countResetButton.subscribe(onNext: { [weak self] in
            self?.reset()
        }).disposed(by: DisposeBag())
    }
    
}

extension CounterViewModel {
    
    private func reset() {
        // 初期値をRelayに流す
        counterRelay.accept(initialCount)
    }
    
    private func incremenet() {
        let count = counterRelay.value + 1
        counterRelay.accept(count)
    }
    
    private func decrement() {
        let count = counterRelay.value - 1
        counterRelay.accept(count)
    }
}

extension CounterViewModel: CounterViewModelOutput {

    // UIを更新するDriverを定義する
    var counterText: Driver<String?> {
        return counterRelay.map { "\($0)" }.asDriver(onErrorJustReturn: nil)
    }
    
}
