# 実施日付

2013年8月10日（土）11:00-16:00 万葉にて。

# やりたいこと

+ [Rails Tutorial(Rails 3.2バージョン)](http://ruby.railstutorial.org/ruby-on-rails-tutorial-book?version=3.2)を進めている。色々と作業を進めて、その都度疑問点を質問したい。
+ @udzuraさんによる『できる！「データベース設計」』の発表＆ワークショップに参加。

## Rails Tutorialを進める

### 1. Railsプロジェクトの作成

Railsプロジェクトを作成します。2013年8月10日現在、現在、`gem install rails`とすると、Rails 4.0がインストールされますので、複数のRailsがひとつのマシンにインストールされている可能性があります。今回は、Rails 3.2.13のバージョンで作業を進めたいので、

```
rails _3.2.13_ sample_app --skip-test-unit
```

とすると、Rails 3.2.13でRailsアプリが作成されます。

### 2. Railsアプリ作成時のオプションについて

上記で書かれている「--skip-test-unit」オプションの他、Railsには多くのオプションが用意されています。

```
rails _3.2.13_ new --help
```
のように、「--help」オプションをつけるとオプションが表示されます。例えば、`rails new`実行時に行われるbundle installをスキップしたいのであれば、「--skip-bundle」オプションを追加すると良いです。

### 3. Gemfileでのバージョン指定について

Rails Tutorialでは、各Gemに対してバージョンを指定しています。Rails Tutorialのように具体的なバージョンを指定しても良いのですが、面倒くさいので、細かいバージョンを指定しなくても良いです。その場合は、bundle install実行時に各Gemで記された依存関係を解消してくれます。

なお、```rails new```したときに生成されるGemに対してはバージョン指定として`~>`や`>=`などが使われています。それぞれの意味は、

* `~>`は一番最後の番号以外の値が一致していて、一番最後の番号は、指定された番号以上の値のもの。例えば、`~> 2.2.1`は、バージョン2.2.1、2.2.2、2.2.3、などはOK。ただ、バージョン2.3.0はNGとなります。
* `>=`は指定されたバージョン以上の値。例えば、`>= 2.2.1`は、バージョン2.2.1、2.2.2、2.2.3、などはOK。更に、2.3.0もOKになります。

* 詳細は、[RubyGemsの5. Specfying Versions](http://docs.rubygems.org/read/chapter/16#page74)を参照してください。

### 4. GemfileでのGroup

`rails new`で生成されたGemfileにはGroupの指定が書かれているものがあります。これは、Railsの環境に応じて、installするgemを指定できたり、requireするgemを指定することができます。

詳細は、[Bundlerのマニュアル](http://bundler.io/v1.3/groups.html)を参照してください。

### 5. RSpec install

Rails Tutorialでは、`rails generate rspec:install`を実行してRSpecをインストールしています。Rails Tutorialではこのように記され、そのまま実行すればOKって感じですが、はじめてのgemだと使い方が分からないことが多いですよね。

そんな時は、まず、gemのGithubリポジトリを参照するようにしてください。

例えば、RSpecの場合は[RSpec-rails](https://github.com/rspec/rspec-rails)のサイトを見るとよいと思います。ここにあるInstllationにある記述が参考になるかと思われます。

### 6. RSpecの記述について

Rails Tutorialでは読み進めていくにつれてRSpecでのテストを書いていきます。RSpecについては日本語のまとまった情報は今のところありません。

日本語書籍として、

* [The RSpec Book](http://books.shoeisha.co.jp/book/b94964.html)

があるのですが、すでに情報が古い状況です（本ではshouldを使った記述をされているが、Rails Tutorialではexpect toを使った書き方をしている）。

参考にするならば、RSpecの開発元である

* [RelishのRSpec Coreのページ](https://www.relishapp.com/rspec/rspec-core/docs)

が一番ではないでしょうか。

また、

* [Everyday Rails Testing with RSpec](https://leanpub.com/everydayrailsrspec)

という電子書籍の評判がいいようです。ご参考に。

### 7. RSpecの表示を楽しくしよう

RSpecの表示はちょっと分かりにくい（成功した時には単にピリオドが表示されるだけ）なのがちょっと寂しいです。

これを解決する`emoji_spec`というものがあります[emoji_spec](https://gist.github.com/meesterdude/6112257)。ちょっと試してみてはいかがでしょうか。

### 8. RSpec/Capybara/Cucumberの違い

話の途中、RSpec/Capybara/Cucumberの違いについて話題になりました。ざっくり言うと、

* RSpecは、テストを実行するための基盤。プログラムを実行して、値と予想値の比較をし、画面表示する。テストが簡単に書くことができるように、比較するためのメソッド（マッチャーと呼びます）もいくつか用意されています。

* CapybaraはWebアプリケーションを操作するかのようなメソッド（visitメソッドやhave_contentマッチャなど）を用意しています。RSpecやCucumberと一緒に使うものと思ってください。

* Cucumberは位置づけ的にはRSpecと同じ位置。テストの書き方がユニークで、自然言語的にかけたりできるのが特徴。また、RSpecはすべてが単体テストという概念ですが、Cucumberはアプリケーション全体を通す概念です。

また、るびま42号には[エンドツーエンドテストの自動化は Cucumber から Turnip へ](http://magazine.rubyist.net/?0042-FromCucumberToTurnip)という記事があります。これまでのテストツールの進化・変遷も書かれているので、合わせて読まれていてはいかがでしょうか。

### 9. 『できる！「データベース設計」』

途中からは[@udzura](https://twitter.com/udzura)さんによる『できる！「データベース設計」』が行われましたので、それを聞くことにしました。

例によって実況ツイートしてみました。[まとめはこちら](http://togetter.com/li/546713)。




