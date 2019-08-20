//
//  ViewController.swift
//  browser
//
//  Created by Kota Sasaki on 2019/08/20.
//  Copyright © 2019 Crunchtimer Inc. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var goButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // デリゲートの設定
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        
        // 初期表示
        let url = URL(string: "https://www.google.com")
        let request = URLRequest(url: url!)
        self.webView.load(request)
    }
    
    // Web読み込み開始
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
        // インジケーターアニメーション開始
        indicator.startAnimating()
        // ボタン更新
        self.updateBrowseButton()
    }

    // Web読み込み完了
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        self.title = self.webView.title
        // インジケーターアニメーション停止
        indicator.stopAnimating()
        // ボタン更新
        self.updateBrowseButton()
    }
    
    // 戻るボタンタップ
    @IBAction func goBack(_ sender: Any) {
        // ブラウザ戻る
        self.webView.goBack()
    }
    
    // 進むボタンタップ
    @IBAction func goForward(_ sender: Any) {
        // ブラウザ進む
        self.webView.goForward()
    }
    
    // 更新ボタンタップ
    @IBAction func reload(_ sender: Any) {
        
        // 画面リロード（再読み込み）
        self.webView.reload()
    }

    // 共有ボタンタップ
    @IBAction func share(_ sender: Any) {
        
        let controller = UIActivityViewController(activityItems: [self.webView.title!, self.webView.url!], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
    }
    
    // 画面遷移前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // 画面インスタンスの取得
        // HACK: 遷移先はUINavigationControllerのため、一つ階層の階層のインスタンスを取得する
        let navi = segue.destination as! UINavigationController
        let vc = navi.viewControllers[0] as! BookmarkTableViewController
        
        // クロージャ（お気に入り画面でタップされたら戻ってくる）
        vc.closure = { (url: String) -> Void in
            // 選択したお気に入りのURLをWebViewに設定し読み込み
            let url = URL(string: url)
            let request = URLRequest(url: url!)
            self.webView.load(request)
        }
    }
    
    // ブラウザボタンの更新
    private func updateBrowseButton() {
        // 戻るボタンの有効/無効設定
        backButton.isEnabled = self.webView.canGoBack
        // 進むボタンの有効/無効設定
        goButton.isEnabled = self.webView.canGoForward
    }
}

