# 実施日付

2013年７月７日（日）11:00-16:00 万葉にて。

# やりたいこと

+ Railsアプリケーションの基礎をやってみたい
+ Twitterに似たアプリケーションを作ってみたい

## Railsアプリケーションの基礎をやってみたい

### 1. Rails 3.2.13をインストールする。

2013年7月7日現在、`gem install rails`とすると、Rails 4がインストールされます。このため、次のようにバージョンを指定して、Rails 3.2.13をインストールしてください。
```
gem install rails -v 3.2.13
```

### 2. `rails new アプリケーション名`でアプリケーションのひな形を作成します。

アプリケーション名は好きな名前を指定してください。今回は、`hogehoge`にしました。また、Rails 3.2.13を使うので、
```
rails _3.2.13_ new hogehoge
```
でアプリケーションを作成します。

### 3. `cd アプリケーション名`でディレクトリ移動

`rails new`コマンドで`hogehoge`ディレクトリが作成されているので、そこに移動します。

```
cd hogehoge
```

### 4. `rails generate scaffold`でEntryに対する作成・更新・参照・削除・一覧表示の機能を作成します。

entryという箱（データベースのテーブル）を作成して、その箱に対する操作（データの作成・億新・参照・削除・一覧表示）の機能を一気に作成してくれるのが`rails generate scaffold`というコマンドです。

`title:string`と`body:text`は箱（データベースのテーブル）に入れるデータの種類を表します。今回は、1行テキストを格納する`title`と複数行のテキストを格納する`body`を用意しました。

1行テキストには、`string`、複数行のテキストを格納するためには`text`を指定します。

以上のことをまとめて、

```
rails generate scaffold entry title:string body:text
```
というコマンドを実行します。

### 5. `rake db:migrate`でテーブルの作成

画面に入力したデータを保存する箱（データベースのテーブル）を保存するために、`rake db:migrate`でテーブルを作成します。

### 6. `rails server`でWebアプリを動かす

以上でアプリケーションが完成しました。`rails server`と入力後、ブラウザで`http://localhost:3000/hogehoge`にアクセスしてみましょう。

## Twitterに似たアプリケーションを作ってみたい

### 0. やる作業の分割

Twitterでできるこはたくさんあるので、まずはやることを分割してみましょう。

+ テキストを入力して、「ツイートする」を押したらデータが登録される
+ ユーザを登録できるようにする
+ 誰がそのツイートをしたのか識別できるようにする
+ フォローできるように
+ mentionとかDMとか
+ etc...

### 1. アプリケーションの作成

アプリケーション名を「nekotter」にして、`rails new`コマンドを実行します。

```
rails new nekotter
```

その後、`nekotter`ディレクトリに移動します。

```
cd nekotter
```

### 2. テキストを入力して、「ツイートする」を押したらデータが登録される

これは先程作成したhogehogeアプリケーションの応用で出来そうです。

```
rails generate scaffold tweet body:text
```

を実行すればOKです。

あとは、ツイートデータを保存する箱（データベーステーブル）を作りましょう。

```
rake db:migrate
```

これで

```
rails server
```

で起動し`http://localhost:3000/tweets/`にアクセスすれば、ツイートできるアプリケーションが確認できるでしょう。

### 3. ユーザを登録できるようにする（準備編）

Twitterでもそうですが、誰がツイートしたのかを管理するためにも、ユーザを登録する機能を作りましょう。

ユーザ管理機能の実装のために、今回は[devise](https://github.com/plataformatec/devise)というGemを使います。

[devise](https://github.com/plataformatec/devise)の説明にある[Getting started](https://github.com/plataformatec/devise#getting-started)を参考に進めていきましょう。

まず、`Gemfile`に`gem 'devise'`を追記し、`bundle install`を実行します。

### 4. deviseの初期ファイルを作成する

次に、deviseの初期ファイルを作成します。これも説明にあるように

```
rails generate devise:install
```

を実行するだけでOKです。

このコマンドを実行すると、[この説明文](https://github.com/plataformatec/devise/tree/master/lib/generators/templates)が出力されます。

このうち、2.に記されている`root_url`の設定と、`app/views/layouts/application.html.erb`の編集を行いましょう。

### 5. `root_url`の設定

`config/routes.rb`を開き、

```ruby
# root :to => 'welcome#index'
```

の部分を

```ruby
root :to => 'tweets#index'
```

に編集します。ツイートの一覧を表示するパスが`tweets#idex`なので、その値を指定しています。

その後、`public/index.html`を削除します。このファイルを削除しないと、ログイン成功後のアクセス先が、`public/index.html`になってしまうので、これを削除しておきます。

### 6. ユーザ情報を格納するテーブルの作成

次に、ユーザ情報（メールアドレスやパスワードなど）を格納するテーブルを作成します。これも、deviseのコマンドを利用することで可能です。

```
rails generate devise user
```

を実行すればOKです。

データベーステーブルの定義ファイルであるmigrationファイルが`db/migrate`以下に作成されてますので、

```
rake db:migrate
```
を実行してテーブルを作成します。

### 7. ログイン・ログアウト・ユーザ登録へのリンクの作成

最後にログイン・ログアウト・ユーザ登録へのリンクを作成します。`app/views/layouts/application.html.erb`を開いて、`<body>`の下に次のプログラムを入力します。

```erb
<% if user_signed_in? -%>
  <%= current_user.email %>
  <%= link_to 'ログアウト', destroy_user_session_path, method: :delete %    >
<% else -%>
  <%= link_to 'ログイン', new_user_session_path %>
  <%= link_to 'ユーザ登録', new_user_registration_path %>
<% end -%>
```

### 8. 実際に試す

実際にアプリケーションを動かしてみましょう。一度実行している`rails server`を`Ctrl + C`で終了させ、`rails server`で再度起動させてください。

ブラウザで、`http://localhost:3000/tweets`にアクセスすると、上に「ログイン」「ユーザ登録」というリンクが出ているのがわかるかと思います。


