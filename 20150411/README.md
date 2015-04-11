# 実施日時

2015年4月11日（土）11:00-16:00 万葉にて。

# やりたいこと・やったこと

* rbenvがうまく動かなかったので、再設定
* Railsアプリを作ってみたい

## rbenvがうまく動かなったので、再設定をする

* rbenvのコマンドがcommand not foundな状態になっている。
* homebrewでインストールしていたり、git cloneでインストールしていたりしているので、整理する。
* homebrewでインストールしていたrbenv関係のものを削除する。
  * コマンドは、`brew uninstall`で。
  * コマンドは、[Qiita](http://qiita.com/vintersnow/items/fca0be79cdc28bd2f5e4)にまとめがあるので、参考に。
* `.bash_profile`にrbenvの設定が複数個書かれていたりするので、それを整理。
* `~/.rbenv/`以下のファイルが、GitHubからcloneしてきた結果とは異なっているように見えたので、再インストール。
* 以上の作業で、無事インストールが完了。

## gemsetについて

* gemsetは、プロジェクトごとに使うgemを個別に管理したいというニーズから生まれたもの。
* プロジェクトで使用するgemがそれぞれ綺麗に整理されて管理できるというメリットがある反面、同じgemが複数箇所に存在してディスクの無駄というデメリットも存在する。
* プロジェクトで使用するgemを綺麗に管理する方法としては、`bundle install --path vendor/bundle`を使って、プロジェクト内に依存するgemを入れておくという方法もある。私はこちらのほうが好み。

## Railsアプリを作ってみたい

* まずは、gemをインストールする。
  * `bundler`と`rails`をインストール
  * `rails`をインストールするときに、なにか失敗した。
  * エラーログを見ると、次のようなエラーメッセージが出ている。

```
Agreeing to the Xcode/iOS license requires admin privileges, please re-run as root via sudo.
```

  * XCodeを起動して、ライセンスに同意すればよい（[参考](http://qiita.com/kazoo04/items/880283612abd85c0610a)）
  * 再度`rails`の再インストールを行うと、また失敗。
  * エラーログを見ると、`xcode-select --install`を実行せよと書かれていたので、それを実行し、画面の指示に従う。
  * 終了後、再度`rails`の再インストールを行うと正常終了した。

* Railsプロジェクトを作る
  * `rails new プロジェクト名`でプロジェクト名のディレクトリが作られる。
  * デフォルトだと、`rails new`した段階で`bundle install`が行われるので、それを止めるために`-B`をつけて実行する。

## bundle install
* 自分のプロジェクト内にgemを入れるために、`bundle install --path vendor/bundle`を実行する。

## Gitでのバージョン管理
* ここまでの作業を一旦保存しておいて、いつでも戻れるようにする。それが、Gitをつかったバージョン管理。
* 標準だと、`vendor/bundle`もバージョン管理の中に入ってしまうんだけど、これらのファイルはインターネットからいつでも手に入るので、これらは保存しないようにする。
  * `.gitignore`ファイルを開いて、`vendor/bundle`を追加するとOK。
* `git init`で初期化して、`git add .`でステージング環境に載せて、`git commit`でコミット。
* 普段の作業は、`git add .`とやって、`git status`で確認して、`git commit`でコミット。

## scaffoldで顧客情報を登録できるフォームや一覧化する機能を作る
* まずは、どのような情報を登録するか。
  * 今回は、会社名、電話番号、住所、担当者を登録したい。
  * 登録する機能や一覧化するためのプロトタイプを作るのが`scaffold`
  * 今回は、`bin/rails generate scaffold customer_info company_name:string telephone_number:string address:string tanto_name:string`と実行するとOK。
  * 実行後、すぐにファイルが作られるので、`bin/rake db:create`と`bin/rake db:migrate`でデータベースとテーブルを作る。
  * 実際に動かしてみる。`bin/rails server`で起動して、ブラウザでhttp://localhost:3000/customer_infos/にアクセスすると、顧客情報などが登録できるようになる。



