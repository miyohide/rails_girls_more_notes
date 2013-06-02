# 実施日付

2013年6月2日（日）12:30-14:30 RubyHirobaにて。

# やりたいこと1

既存のRailsアプリにTwitterBootStrapをインストールしてそのスタイルを適用したい。

## TwitterBootStrap インストール

Gemfileに対して、[bootstrap-sass](https://github.com/thomas-mcdonald/bootstrap-sass)を追加。

## Railsアプリケーションに対する修正

以下2つの作業を実施。
`application.css.scss`に対して`@import "bootstap";`を追加。
`application.js`に対して、`//= require bootstrap`を追加。

## 実際に適用

例えば、リンクに対して、スタイルを適用。

`link_to '名前', url`を`link_to '名前', url, :class => 'btn btn-info'`と書き換えるとOK。

## 参考情報

RailsでTwitterBootStrapを使いたいというとき、色々とgemがあります。

- [twitter-bootstrap-rails](https://github.com/seyhunak/twitter-bootstrap-rails)
- [bootstrap-sass](https://github.com/thomas-mcdonald/bootstrap-sass)
- [chosen-sass-bootstrap-rails](https://github.com/Wealcash/chosen-sass-bootstrap-rails)

いろいろなgemがあり迷いますが、QA@ITの質問「[RailsでBootstrapのgemのおすすめは？](http://qa.atmarkit.co.jp/q/2658)」でいろんな人が紹介している`bootstrap-sass`を紹介しました。

# やりたいこと2

HTML内に直接書かれていたJavaScriptを`app/assets/javascript`以下に置きたい。

## やったこと

書かれているJavaScriptを`application.js`に移動。

## 発生した問題1

JavaScript内で`<%= %>`でデータを参照している。
結果として、JavaScriptがSyntaxエラー（文法エラー）となりJavaScriptが動かなくなりました。

## 問題への対応1

gonというgemを使ってみる。

参考サイトとして、[RailsCasts](http://railscasts.com/episodes/324-passing-data-to-javascript?language=ja&view=asciicast)を見ながら。変数名にgon.と付けばアクセスできるみたい。

JavaScript側からは、もともと書いてあった`<%= 変数名 %>`を変えて、`gon.変数名`の形でアクセスするとOK。

## 発生した問題2

`gon.name = @state.name`で`You can't use gon public methods for storing data`が発生。

## 問題への対応2

変数名を`name`から`hoge`に変更したところ、うまく行った。

# coffeescriptを使わない

Gemfileからcoffee-rails をコメントアウトする。

# Gemfileに対してgemを追加する

好きな所でOK。

# 作業内容のコミット

- `git add`でファイルをコミットする対象として登録。
- `git commit`でファイルをコミット。
- `git rm`でファイルをgitから削除。

# Kaminariでページ分割をやりたい

RailsCastsにある[Kaminariの解説](http://railscasts.com/episodes/254-pagination-with-kaminari?language=ja&view=asciicast)を紹介。

後は自習で。



