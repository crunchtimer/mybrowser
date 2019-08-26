# スタートプログラミングエキスパートコース課題①
## ブラウザアプリ

このアプリはスタートプログラミングのエキスパートコースの課題①です。
ブラウザアプリを作ります。

## ルール

以下に記述するアプリ要件（満たすべき動作）を守っていればどんな実装をしてもかまいません。  
また、自由に機能追加や改変をして、他の人とは違う、使いやすくて楽しいアプリを作ってください。  

## アプリ基本仕様
- アプリアイコンが設定されていること
- バイリンガル設定（英語・日本語）がされていること
- アプリ名が設定されていること
- ブラウザ画面とお気に入りページの画面が表示されること
- どの端末でもレイアウトが崩れることなく表示されること

### ブラウザ画面
#### 基本仕様

- UINavigationControllerで実装されていること
- 画面タイトルには表示されているWebページのタイトルが表示されていること
- 初期画面はGoogleが表示されていること
- ナビゲーションタイトル横に更新ボタンが設置されており、タップするとWebページを更新（リロード）すること
- Webページを読み込んでいる間にはインジケーター（ぐるぐる）が表示されること
- Webページを読み込んだあとは、インジケーターが表示されないこと
- UIToolbarが設置されていること
- ツールバーには「戻る・進む・共有・お気に入り」の4つのボタンが設置されていること
- 戻るボタンや進むボタンはWebページに履歴がない場合はdisable状態となること
- 戻るボタンをタップするとブラウザの履歴をたどって戻ること
- 進むボタンをタップするとブラウザの履歴を進むこと
- 共有ボタンをタップするとUIActivityViewControllerを表示し、アプリに情報（ページのタイトルとURL）が共有ができること
- お気に入りボタンをタップするとお気に入り画面が表示されること

### お気に入り画面
#### 基本仕様
- UINavigationControllerで実装されていること
- UITableViewControllerで実装されていること
- 画面タイトルにはお気に入りと表示すること
- キャンセルボタンを表示し、キャンセルをタップすると画面を閉じること
- キャンセルボタンタップ時にはWebページを更新しないこと
- お気に入りリストを表示（複数）すること
- リストがをタップすると画面を閉じ、選択したWebページが表示されること


### ヒント

#### WebViewの更新について

WebViewはページの「戻る」「進む」「更新」機能を実装していますが、それぞれWKWebViewのメソッドを使っています。
```
戻る：goBack()
進む：goForward()
更新：reload()
```

また、Webページを表示した履歴（戻るページや進むページがあるか）も以下のWKWebViewのメソッドで知ることができます。
```
戻る：canGoBack（Bool型）
進む：canGoForward（Bool型）
```

#### WebViewの更新タイミング
WebViewの更新開始と完了のタイミングはデリゲートを使うことでわかります。

```
class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // デリゲートの設定
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
    }
}
```

デリゲートを設定すると、それぞれWebViewの読み込み開始のタイミングと読み込み完了のタイミングで以下のメソッドが呼ばれます。

```
// Web読み込み開始
func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
}
// Web読み込み完了
func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
}
```

#### お気に入り画面から選択したURLを渡すには？
このサンプルではクロージャーを使っています。
ViewController.swiftにある以下の処理を参考にしてください。

```
// 画面遷移前処理
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    // クロージャ（お気に入り画面でタップされたら戻ってくる）
    vc.closure = { (url: String) -> Void in
        // 選択したお気に入りのURLをWebViewに設定し読み込み
        let url = URL(string: url)
        let request = URLRequest(url: url!)
        self.webView.load(request)
    }
}
```
