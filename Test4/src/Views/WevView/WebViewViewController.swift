//
//  WebViewViewController.swift
//  Test4
//
//  Created by 山本裕太 on 2019/11/02.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa
import RxOptional

class WebViewViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var progressView: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }

}

extension WebViewViewController {
    
    private func setupWebView() {
        
        // filterNil()でnilじゃない場合はアンラップし、nilの場合は値を流さないようにする
        let loadingObservable = webView.rx.observe(Bool.self, "loading")
            .filterNil()
            .share()
        
        // progressバー制御
        loadingObservable
            .map { return !$0 }
            .bind(to: progressView.rx.isHidden)
            .disposed(by: rx.disposeBag)
        
        // タイトル表示
        loadingObservable.map{ [weak self] _ in
            return self?.webView.title
        }
        .bind(to: navigationItem.rx.title)
        .disposed(by: rx.disposeBag)
        
        // iPhone上部のインジケータ制御
        loadingObservable
            .bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: rx.disposeBag)
        
        // progressバーのゲージ制御
        webView.rx.observe(Double.self, "estimatedProgress")
            .filterNil()
            .map { return Float($0) }
            .bind(to: progressView.rx.progress)
            .disposed(by: rx.disposeBag)
        
        let url = URL(string: "https://www.google.com/")
        let urlRequest = URLRequest(url: url!)
        webView.load(urlRequest)
    }
}

extension WebViewViewController {
    
    static func instance() -> UIViewController {
        guard let vc = R.storyboard.webView.webViewViewController() else {
            return UIViewController()
        }
        return vc
    }

}
