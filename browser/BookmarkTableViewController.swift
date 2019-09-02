//
//  BookmarkTableViewController.swift
//  browser
//
//  Created by Kota Sasaki on 2019/08/20.
//  Copyright © 2019 Crunchtimer Inc. All rights reserved.
//

import UIKit

class BookmarkTableViewController: UITableViewController {

    // リストタイトル
    let titles = ["ヤフー", "Google", "Rakuten", "Facebook", "Twitter", "Youtube", "任天堂"]
    
    // URL
    let urls = [
        "https://www.yahoo.co.jp",
        "https://www.google.com",
        "https://www.rakuten.co.jp",
        "https://www.facebook.com",
        "https://twitter.com",
        "https://www.youtube.com",
        "https://www.nintendo.co.jp"
    ]
    
    // クロージャー（String型の引数、返却値なし）
    var closure: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ページタイトル
        title = NSLocalizedString("Bookmark", comment: "")
    }

    // セクション数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // セクションあたりのセル数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    // セルの生成
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // タイトルの設定
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
    
    // セルタップ
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // クロージャーを呼び出して、前画面にURLを通知
        self.closure!(urls[indexPath.row])
        // 画面閉じる
        self.dismiss(animated: true, completion: nil)
    }

    // 完了ボタンタップ
    @IBAction func done(_ sender: Any) {
        
        // 画面閉じる
        self.dismiss(animated: true, completion: nil)
    }
}
