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

    // MARK: - Variables

    // document reference
    let userDocument: Document<User> = Document()
    // initialize class to handle tap event
    let tapGesture = UITapGestureRecognizer()
    
    /**
     *  document.data?.number -> Optional<Int>
     *  document[\.number] -> Int
     */

    // MARK: - lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()
        addAction()
        subscribeUI()
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
    }

}

// MARK: -
