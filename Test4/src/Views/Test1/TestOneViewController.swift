//
//  TestOneViewController.swift
//  Test4
//
//  Created by 山本裕太 on 2019/10/20.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Ballcap
import Firebase

// remote config stringKey raw value
enum RemoteConfigKeys: String {
    case testTextLabel = "test_text_label"
    case sendingMessageLabel = "sending_message_label"
}

/**
 * User create scene
 */
class TestOneViewController: UIViewController {
    
    private weak var presenter: UsersPresenterProtocol!

    // MARK: - Outlets
    
    // user name text field
    @IBOutlet weak var userNameTextField: UITextField!
    // password text field
    @IBOutlet weak var passwordTextField: UITextField!
    // create user button
    @IBOutlet weak var createUserButton: UIButton!
    // current user name
    @IBOutlet weak var currentUserName: UILabel!
    // current user password
    @IBOutlet weak var currentUserPassword: UILabel!
    // current user identifier
    @IBOutlet weak var currentUserIdentifier: UILabel!
    // fetch remote config button
    @IBOutlet weak var fetchRemoteConfigButton: UIButton!
    

    // MARK: - Variables

    // document reference
    let userDocument: Document<User> = Document()
    // initialize class to handle tap event
    let tapGesture = UITapGestureRecognizer()
    
    let remoteConfig: RemoteConfig = RemoteConfig.remoteConfig()
    
    let setting: RemoteConfigSettings = RemoteConfigSettings()
    

    
    /**
     *  document.data?.number -> Optional<Int>
     *  document[\.number] -> Int
     */

    // MARK: - lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRemoteConfig()
        addAction()
        subscribeUI()
        // remote config instance
        setting.minimumFetchInterval = 0
        // settingを追加
        remoteConfig.configSettings = setting
    }

}

// MARK: - Private Functinos

extension TestOneViewController {
    
    private func addAction() {
        // register tap event into view
        view.addGestureRecognizer(tapGesture)
    }
    
    private func subscribeUI() {
        // close keyboard when tapping view
        tapGesture.rx.event.bind(onNext: { [unowned self] _ in
            self.view.endEditing(true)
        }).disposed(by: rx.disposeBag)
        
        createUserButton.rx.tap.subscribe(onNext: { [unowned self] in
            self.presenter.createUser(name: self.userNameTextField.text, password: self.userNameTextField.text)
        }).disposed(by: rx.disposeBag)
        
        fetchRemoteConfigButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.setTextLabelFromRemoteConfig()
        }).disposed(by: rx.disposeBag)
    }
    
    /// function to fetch remote config
    private func fetchRemoteConfig() {
        remoteConfig.fetch(withExpirationDuration: 20) { [weak self](status, error) -> Void in
            guard let _self = self else { return }
            if status == .success {
                _self.remoteConfig.activate { error in
                    // if fetching feiled handling..
                    if let e = error {
                        print(e)
                        return
                    }
                    print("** fetching success!!")
                }
            } else {
                print("**Config not fetched")
                print("**Error: \(error?.localizedDescription ?? "no error available")")
            }
        }
    }
    
    private func setTextLabelFromRemoteConfig() {
        currentUserName.text = remoteConfig[RemoteConfigKeys.testTextLabel.rawValue].stringValue
        currentUserPassword.text = remoteConfig[RemoteConfigKeys.sendingMessageLabel.rawValue].stringValue
    }

}

// MARK: -
