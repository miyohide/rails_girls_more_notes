# 実施日付

2013年6月2日（日）12:30-14:30 RubyHirobaにて。

# やりたいこと1

既存のRailsアプリにTwitterBootStrapをインストールしてそのスタイルを適用したいです。

## TwitterBootStrap インストール

Gemfileに対して、[bootstrap-sass](https://github.com/thomas-mcdonald/bootstrap-sass)を追加します。その後、`bundle install`するとOK。`rails server`を起動していた場合は、一度終了し、再度`rails server`を起動します。

## Railsアプリケーションに対する修正

以下2つの作業を実施します。

- `application.css.scss`に対して`@import "bootstap";`を追加します。
- `application.js`に対して、`//= require bootstrap`を追加します。

## 実際に適用

例えば、リンクに対してスタイルを適用してみましょう。

`link_to '名前', url`を`link_to '名前', url, :class => 'btn btn-info'`と書き換えるとOKです。

## 参考情報

RailsでTwitterBootStrapを使いたいというとき、色々とgemがあります。

- [twitter-bootstrap-rails](https://github.com/seyhunak/twitter-bootstrap-rails)
- [bootstrap-sass](https://github.com/thomas-mcdonald/bootstrap-sass)
- [chosen-sass-bootstrap-rails](https://github.com/Wealcash/chosen-sass-bootstrap-rails)

いろいろなgemがあり迷いますが、QA@ITの質問「[RailsでBootstrapのgemのおすすめは？](http://qa.atmarkit.co.jp/q/2658)」でいろんな人が紹介している`bootstrap-sass`を紹介しました。

# やりたいこと2

HTML内に直接書かれていたJavaScriptを`app/assets/javascript`以下に置きたいです。

## やったこと

書かれているJavaScriptを`application.js`に移動します。

## 発生した問題1

JavaScript内で`<%= %>`でデータを参照している箇所が(・。・;

結果として、JavaScriptがSyntaxエラー（文法エラー）となりJavaScriptが動かなくなりました。

## 問題への対応1

gonというgemを使ってみましょう（タンスにgon...）。

参考サイトとして、[RailsCasts](http://railscasts.com/episodes/324-passing-data-to-javascript?language=ja&view=asciicast)を見ながら。変数名にgon.と付けばアクセスできるみたいです。

インストールはいつもの様に`Gemfile`に`gem 'gon'`を追加して、`bundle install`を実行します。

このとき、`rails server`を実行している場合は、一旦終了。再度`rails server`を実行してください。こうすることで、インストールした`gon`が使えるようになります。

JavaScript側からは、もともと書いてあった`<%= 変数名 %>`を変えて、`gon.変数名`の形でアクセスするとOKです。

## 発生した問題2

`gon.name = @state.name`で`You can't use gon public methods for storing data`が発生しました。

## 問題への対応2

変数名を`name`から`hoge`に変更したところ、うまく行きました＼(^o^)／

# coffeescriptを使わない

`Gemfile`から`coffee-rails`をコメントアウトして再度、`bundle install`を行うとOKです。

# Gemfileに対してgemを追加するとき、どこに追加したら良いのでしょう。

好きな所でOKです。

私は一番最後の行に追加するようにしています。

# 作業内容のコミット

何か作業を行ったら、バージョン管理システムにコミットしておきましょう。RailsGirlsではGitを使っているので、次の手順でコミットしておきましょう。

- `git add`でファイルをコミットする対象として登録します。
- `git commit`でファイルをコミットします。
- （今回は削除するファイルが有ったので）`git rm`でファイルをgitから削除できます。

# Kaminariでページ分割をやりたい

RailsCastsにある[Kaminariの解説](http://railscasts.com/episodes/254-pagination-with-kaminari?language=ja&view=asciicast)を紹介しました。

後は自習でm(_ _)m



