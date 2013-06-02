# Rails Girls More 実施内容

## 1. 貯金額を保存するための処理（保存するためのDB、画面、各種操作）を作る

    $ rails generate scaffold savings date:date price:integer

ここで指定するテーブルのカラムの型は[Railsドキュメントのマイグレーション](http://railsdoc.com/migration "Railsドキュメントのマイグレーション")を参考にするといいかも。

## 2. スペルミスとかしたら、一度削除して作りなおすことができる

    $ rails d scaffold savings date:date price:integer
    $ rails g scaffold savings date:date price:integer

## 3. データベースの作成

    $ rake db:migrate

## 4. Webサーバの起動

    $ rails server

## 5. 動いたなら、コミットしよう。gitリポジトリを作成する。

    $ git init

## 6. gitでコミット。コミットは最低限これだけを覚えればOK。

    $ git add .
    $ got commit -m "initial commit"

## 7. index画面に貯金額の合計を出す。

ViewでもControllerでもModelでも好きなところにかけるんですが、Modelに書くのがBest Practice。

→app/models/saving.rbに合計を求める処理を実装。

## 8. どうやって合計を求める？

ControllerのindexアクションでSaving.allっていうのがあったよね。

→あれでsavingsテーブルにあるすべてのレコードを取得出来ます。

→そこから一件一件取り出すには？

→eachを使う。

    sum = 0
    Saving.all.each do |saving|
      sum += saving.price
    end
    sum

**（追記）上のプログラムはもっと短い書き方ができるのでチャレンジ。**

## 9. Controllerでsumメソッドを呼び出し、それを@sumに格納する。

    @sum = Saving.sum

## 10. viewで@sumを参照すると、合計額を出すことができる。

    今の貯金：<%= @sum %>円

## 11. メール送信したい。

Googleで検索すると、[分かりやすそうなサイト(ActionMailer Railsアプリからメールを送信)](http://morizyun.github.com/blog/action-mailer-rails-mail/ "ActionMailer Railsアプリからメールを送信")を発見。ここを参考に。

メール送信するためのクラスなどを作成する。

    $ rails g mailer message notice

## 12. rails consoleで動くか確認

    $ rails console
    > Message.notice.deliver

## 13. viewにメール送信を指示するリンクを作成

send_mail_savings_pathは次のconfig/routes.rbで作成する。

    <%= link_to 'メール送信', send_mail_savings_path %>

## 14. config/routes.rbにメール送信用のルートを作成

savingsのルートに対して、send_mailというルートを追加する。

    SaveMoney::Application.routes.draw do
      # 元々はresources :savingsとなっているのをdo - endでくくる
      resources :savings do
        # 下三行を追加。
        collection do
          get 'send_mail'
        end
      end
    end

ルートの作成の確認は、`$ rake routes`で

## 15. Controllerにアクションを作成。

      def send_mail
        Message.notice.deliver
      end

## 16. TemplateMissingがでた〜

次の画面を指示する。

      def send_mail
        Message.notice.deliver
        redirect_to action: :index
      end

**（追記）メールの確認は、consoleで流れるものを見てもいいけど、[MailCatcher](http://mailcatcher.me/ "MailCatcher")を試してもいいかも。**

## 17. Hashの書き方

これらは全部一緒

        :action => "index"
        :action => :index
        action: :index

シンボルと文字列の違いは[ここ(文字列にするか、シンボルにするか、いったい何が違うのだ？)](http://d.hatena.ne.jp/zariganitosh/20061118/1163851550 "ここ(文字列にするか、シンボルにするか、いったい何が違うのだ？)")を見ると良いかも。

## 18. メールリンクの作成

viewでmail_toを使うとOK。

    <%= mail_to "mail_address@example.com", "メールアドレス" %>

## 19. 金額がマイナスだったら文字を赤くしたい

文字を赤くするのは？

→`style`を指定してあげればよい。

→金額がマイナスのときをどうやって判断する？

→viewの中では`<%  %>`の中でRubyの式がかける。こんな感じで。

    <% if @sum > 0 %>
      <span><%= @sum %></span>
    <% else %>
      <span class="red"><%= @sum %></span>
    <% end %>

## 19. CSSでかっちょよくしたい。

Foundationのインストール。[Foundationの公式サイトの記述](http://foundation.zurb.com/docs/rails.html "Foundationの公式サイトの記述")を参考に。

## 20. インストール

Gemfileの中に`gem 'zurb-foundation', '~> 4.0.0'`を追加する。`group :assets do`の中に書くのがポイント。

    group :assets do
      gem 'sass-rails',   '~> 3.2.3'
      gem 'coffee-rails', '~> 3.2.1'

      # See https://github.com/sstephenson/execjs#readme for more supported runtimes
      # gem 'therubyracer', :platforms => :ruby

      gem 'uglifier', '>= 1.0.3'
      gem 'zurb-foundation', '~> 4.0.0'
    end

その後、`bundle install`。gemのインストールが済んだら、

    $ rails g foundation:install

## 21. インストール後はrails serverを再起動する

