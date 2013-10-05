# 実施日付

2013年10月5日（土）11:00-16:00 万葉にて。

# やりたいこと

+ [Rails Girlsのチュートリアル](http://railsgirls.jp/app/)の復習をしつつ、随時質問を受け付ける。

## Rails Girlsのチュートリアルを進める

### 1. アプリケーションを作る

### 2. Ideaのscaffoldをする

* Ideaとは何でしょうか
  * アイデアを管理するツールです。
  * アイデアの名前（name）とその詳細（description）、図（picture）を保存できるようにし、参照や削除、編集を行えるWebアプリケーション。
  * 図（picture）は最初は単なる文字列ですが、最後にファイルのアップロードができるようにします。
* scaffoldとは何でしょうか
  * 英単語の意味では「土台」とか「骨組み」といった意味。
  * railsでは、管理するアイデアに対して作成・参照・更新・削除が行える簡単なWebアプリケーションのひな形を作ってくれます。
  * 具体的には、アイデアを保存するためのテーブルを定義する「migration」、テーブルに対してデータの作成や参照などの操作が行える「model」、Web画面の表示内容を記す「view」、「model」に対して処理を行ったり「view」に対して表示するデータを設定する「controller」を作成します。他にも「helper」や「Javascript」、「Stylesheet」、「test」を作成します。
* `db:migrate`とは何でしょうか
  * 先ほどscaffoldで作成した「migration」ファイルを実行してテーブルを作成します。

### 3. デザインする

### 4. 写真アップロード機能を追加する

### 5. 今後について

* 今後の勉強となる資料について
  * RailsTurorialを使って一通り実施するのがよいかと。Ruby/Railsでアプリケーションを作るということに限らず、Gitを使ったバージョン管理やHerokuへのアップロード、Railsアプリケーションに対するテストについても書かれていてよい資料と考えている。
  * 日本語が最近整備されたので、日本語版で読み進めると良いかと。
  * RailsによるアジャイルWebアプリケーション開発 第4版が書籍としてあるが、Railsのバージョンが3.1であり、最新版でないのが気がかり。Rails 3.2で同じ内容を試してみたことがあるが、様々なところで本の記載通りに書いても動かない部分があり、難しい。
  * 英語版はRails4に対応していて、アプリケーションの作成部分についてやることは変わっていないので、日本語版で概要を理解して英語版に望んでみても良いかも。

* RubyGemsの探し方について
  * 「4. 写真アップロード機能を追加する」にて、突如として「carrierwave」が出てきた。このように「何かをやりたい」といったときにRubyGemsを探すには？
  * ひとつは、[Ruby ToolBox](https://www.ruby-toolbox.com/)で検索する。便利なものは大体ライブラリ化されているので、そこで検索すると良いかと。
  * 後は、RailsGirls, Moreで質問すると良いかと。

* RubyGemsのバージョン指定について
  * `~>`は一番最後の番号以外の値が一致していて、一番最後の番号は、指定された番号以上の値のもの。例えば、`~> 2.2.1`は、バージョン2.2.1、2.2.2、2.2.3、などはOK。ただ、バージョン2.3.0はNGとなります。
  * `>=`は指定されたバージョン以上の値。例えば、`>= 2.2.1`は、バージョン2.2.1、2.2.2、2.2.3、などはOK。更に、2.3.0もOKになります。
  * 詳細は、[RubyGemsの5. Specfying Versions](http://docs.rubygems.org/read/chapter/16#page74)を参照してください。

* GemfileでのGroup
  * テスト環境用、開発環境用などで使うRubyGemsを変えたい場合は、Gemfileを個別に用意する必要がありますか。
  * Gemfileはひとつで、groupによって指定することによって解決します。
  * 詳細は、[Bundlerのマニュアル](http://bundler.io/v1.3/groups.html)を参照してください。
  * Gemfileを複数個作成して、実行時に特定のGemfileを指定するのは`--gemfile Gemfile名`で指定すればよい。
