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

class TestOneViewController: UIViewController {
    
    
    @IBOutlet weak var testButton: UIButton!

    let document: Document<User> = Document()
    
    /**
     *  document.data?.number -> Optional<Int>
     *  document[\.number] -> Int
     */

    override func viewDidLoad() {
        super.viewDidLoad()
//        subscribeUI()
    }
    
    private func subscribeUI() {
        testButton.rx.tap.subscribe(onNext: { [unowned self] in
            print("")
        }).disposed(by: rx.disposeBag)
    }
    
    
    
    @IBAction func tapButton(_ sender: Any) {
        document.save()
    }
    
    
    

}
