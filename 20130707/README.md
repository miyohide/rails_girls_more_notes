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
  <%= link_to 'ログアウト', destroy_user_session_path, method: :delete %>
<% else -%>
  <%= link_to 'ログイン', new_user_session_path %>
  <%= link_to 'ユーザ登録', new_user_registration_path %>
<% end -%>
```

### 8. 実際に試す

実際にアプリケーションを動かしてみましょう。一度実行している`rails server`を`Ctrl + C`で終了させ、`rails server`で再度起動させてください。

ブラウザで、`http://localhost:3000/tweets`にアクセスすると、上に「ログイン」「ユーザ登録」というリンクが出ているのがわかるかと思います。

## バージョン管理システムへの登録

ここまでの作業である程度一段落したので、バージョン管理システムを使って現在の状況を保存しておきましょう。

バージョン管理システムとは、ファイルの作成日時、変更日時、変更点などの履歴を保管して、何度も変更を加えたファイルであっても過去の状態に戻れたり、変更内容を確認できるようにするソフトウェアです。

今回は、バージョン管理システムとしてGitを利用することにします。

### 1. 初期化作業

nekotterディレクトリの直下で

```
git init
```

と入力してください。この作業は最初の1回だけでOKです。

### 2. コミット

コミットとは、現在の状態をバージョン管理システム（VCS）に登録する作業のこといいます。Gitにおけるコミットは2段階の作業が必要です。

`git add ファイル名`でファイルをコミット対象として登録します。コミット対象のファイルが複数個ある場合は、`git add .`（ピリオド）ですべてをコミット対象とすることができます。

その後、`git commit -m コミットメッセージ`でファイルをコミットします。

### 3. 修正したものの確認

`git status`と入力すると、変更したファイル・追加したファイル・削除したファイルなどが表示されます。

### 4. 今後は・・・

今後は、自分のタイミングで`git add`と`git commit`を行なってください。タイミングが難しいとは思いますが、ファイルを変更して、自分の思い通りのことが実現できたらコミットする癖をつけておくと良いでしょう。

## Rails 4.0.0でdeviseを使う

2013年7月7日（日）現在、Ruby on Rails 4.0.0でdeviseを使おうとすると、問題が発生します。具体的には、

```
rails generate devise user
```

を実行した後、

```
rake db:migrate
```

を実行すると、次のようなエラーメッセージが出力されます。

```
rake aborted!
`attr_accessible` is extracted out of Rails into a gem. Please use new recommended protection model for params(strong_parameters) or add `protected_attributes` to your Gemfile to use old one.
/Users/miyohide/rails_girls_sample/nekotter_v4/vendor/bundle/ruby/2.0.0/gems/activemodel-4.0.0/lib/active_model/deprecated_mass_assignment_security.rb:14:in `attr_accessible'
/Users/miyohide/rails_girls_sample/nekotter_v4/app/models/user.rb:8:in `<class:User>'
/Users/miyohide/rails_girls_sample/nekotter_v4/app/models/user.rb:1:in `<top (required)>'
（以下略）
```

これを解決するためには、次の作業を行います。

### 1. 自動生成したファイルを削除する

`rails generate devise user`で生成された次のファイルを削除します。

+ app/models/user.rb
+ db/migrate/日付＋時間+_devise_create_users.rb
+ test/fixtures/users.yml
+ test/models/user_test.rb

また、変更されたファイル（config/routes.rb）も修正します。

```ruby
NekotterV4::Application.routes.draw do
  devise_for :users  # <- この行を削除する
  resources :tweets
  # （以下省略）
end
```

gitでバージョン管理をしていて、`rails generate devise:install`の直後にコミットしていたら

```
git clean -f
git checkout .
```

と打てばOKです。

### 2. deviseの新バージョンをGemfileに記述する

その後、deviseの新バージョンをGemfileに記述します。具体的には、Gemfileに

```
gem 'devise'
```

と書いていたところを

<s> gem 'devise', '3.0.0.rc' </s>

```
gem 'devise'
```

と書いて、

```
bundle install
```

コマンドを実行します。

*2013年7月16日（火）追記 deviseがバージョンアップして、上に書いたように'3.0.0.rc'のようにバージョン指定しなくても良くなりました。*

### 3. devise:install

deviseの新しいバージョンのインストールが終わると、次は`rails generate devise:install`コマンドを実行します。

実行時、

```
[DEVISE] Devise.use_salt_as_remember_token is deprecated and has no effect. Please remove it.
    conflict  config/initializers/devise.rb
Overwrite /Users/miyohide/rails_girls_sample/nekotter_v4/config/initializers/devise.rb? (enter "h" for help) [Ynaqdh]
```

というメッセージが出てきます。これは古いバージョンで作ったものを上書きするかの確認メッセージなので、Enterキーを押して上書きするようにしましょう。

同じように`config/locals/devise.en.yml`に対しても上書きを行なってください。

```
[DEVISE] Devise.use_salt_as_remember_token is deprecated and has no effect. Please remove it.
    conflict  config/initializers/devise.rb
Overwrite /Users/miyohide/rails_girls_sample/nekotter_v4/config/initializers/devise.rb? (enter "h" for help) [Ynaqdh]
       force  config/initializers/devise.rb
    conflict  config/locales/devise.en.yml
Overwrite /Users/miyohide/rails_girls_sample/nekotter_v4/config/locales/devise.en.yml? (enter "h" for help) [Ynaqdh]
       force  config/locales/devise.en.yml
```

### 4. userモデルの作成

再度、`rails generate devise user`を実行し、userモデルなどを作成します。

その後、`rake db:migrate`を実行すると、今度はうまくテーブルを作ることができます。

```
==  DeviseCreateUsers: migrating ==============================================
-- create_table(:users)
   -> 0.0104s
-- add_index(:users, :email, {:unique=>true})
   -> 0.0007s
-- add_index(:users, :reset_password_token, {:unique=>true})
   -> 0.0006s
==  DeviseCreateUsers: migrated (0.0119s) =====================================
```

### 5. ログイン・ログアウト・ユーザ登録へのリンクの作成

最後にログイン・ログアウト・ユーザ登録へのリンクを作成します。これはRails 3.2.13でやったことと同じ事です。

`app/views/layouts/application.html.erb`を開いて、`<body>`の下に次のプログラムを入力します。

```erb
<% if user_signed_in? -%>
  <%= current_user.email %>
  <%= link_to 'ログアウト', destroy_user_session_path, method: :delete %>
<% else -%>
  <%= link_to 'ログイン', new_user_session_path %>
  <%= link_to 'ユーザ登録', new_user_registration_path %>
<% end -%>
```

### 6. 実際に試す

実際にアプリケーションを動かしてみましょう。一度実行している`rails server`を`Ctrl + C`で終了させ、`rails server`で再度起動させてください。

ブラウザで、`http://localhost:3000/tweets`にアクセスすると、上に「ログイン」「ユーザ登録」というリンクが出ているのがわかるかと思います。

ログインやユーザ登録等ができることを確認しましょう。

