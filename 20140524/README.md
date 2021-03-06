# 実施日付

2014年5月24日（土）11:00-16:00 万葉にて。

# やりたいこと

* Rails Girlsでやった[作業](http://railsgirls.jp/)のリトライ

## Rails環境のインストール

* Windowsのユーザ名は、日本語だと上手くいかないことが多いので、英語で作りなおしたほうが良いです。

* Windows環境では、[RailsInstaller](http://railsinstaller.org/en)というのがあって、これでファイルをダウンロードし、ダウンロードしたファイルをダブルクリックするとインストールが始まるので、後は画面の指示に従えばOK。

* インストールした結果、作られる「Command Prompt with Ruby on Rails」をダブルクリックして、起動した（黒い）画面で`ruby -v`や`rails -v`と打ち、バージョン番号が出てきたら、RubyやRailsのインストールが上手く行っています。
  * `ruby -v`はRubyのバージョンを表示するためのコマンドです。
  * `rails -v`はRailsのバージョンを表示するためのコマンドです。
  * 一般的に、`-v`というオプションをつけると、バージョン番号が表示されます。

* インストールされているバージョンは、若干古いのですが、このパソコン上で動かすだけなので、特に問題はありません。先に進みましょう。

* `gem update rails --no-ri --no-rdoc`の`--no-ri`や`--no-rdoc`はドキュメントの生成を行わないためのオプション。
  * これをつけないと、ドキュメント生成処理が実行され、処理時間がかかります。
  * ドキュメントは、`gem server`と黒い画面で打って、ブラウザで`http://localhost:8808/`にアクセスすると参照することが出来ます。
  * ですが、インターネットで検索することが多いので、あまり使わないです。

## 黒い画面（コマンドプロンプト）でのコマンド

* 黒い画面をこれからはコマンドプロンプトと呼びます。
* コマンドプロンプトで打ったコマンドの意味は次のとおりです。
  * `mkdir`はフォルダを作成する
  * `cd`はフォルダに移動する
  * `rails server`はRailsアプリケーションを起動する
  * `rails generate scaffold`はRailsアプリケーションの骨組みを作成する。これだけで、箱（データベース）に値を入れる処理や参照処理、一覧表示処理、編集処理、削除処理が実装される
  * `bin/rake db:migrate`は`db/migrate`以下にあるファイルをみて、箱（データベース）を作成する

## デザインするについて

* [Twitter Bootstrap](http://getbootstrap.com/)というものを使います。
  * ですので、ここで書かれていることは、Twitter Bootstrapで定められたルールです。
  * 例えば、`<%= yield %>`を`<div class="container> </div>`で囲むというのはTwitter Bootstrapで定められたルールです。
  * というわけで、上のリンクや、実際に実行してみて試してみましょう。

## ファイルアップロードについて

* 今回は、[carrierwave](https://github.com/carrierwaveuploader/carrierwave)という部品（gem）を使います。
* マニュアルは、上記のサイトに記述されていますので、読んでみてください。
* といっても、英語は苦手・・・ということもあるので、例えば、[asciicasts.comでの紹介ページ](http://ja.asciicasts.com/episodes/253-carrierwave-file-uploads)を参照してもよいでしょう。
* ここでの記述方法もcarrierwaveで定めたルールですので、そのとおりにしてみましょう。
* 今回の例では、`show`の画面だけを修正しました。
  * 例えば、追加で`index`の画面に対しても画像が表示されるように修正してみましょう。

## やりたいこと

* ircのボットを作りたいです。
  * [cinch](https://github.com/cinchrb/cinch)という部品（gem）で出来そうです。

