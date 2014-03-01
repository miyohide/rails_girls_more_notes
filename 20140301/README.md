# 実施日付

2014年3月1日（土）11:00-16:00 万葉にて。

# やりたいこと

* Webアプリケーション開発について色々疑問に思ったことを解決していく。
* テーマは以下のもの
  * セキュリティ
  * 管理画面
  * OR Mapperについて
  * Railsの勉強について

## セキュリティについて

* Cookieの中身が暗号化されていないのが気になる。
  * Rails4では暗号化されている。
  * Rails3までは暗号化されていない。
  * 上記のことを確認してみよう。
    * Rails3では「\_rails3\_scaffold_session」キーの値が変数`v`に入っているとき、`Marshal.load(Base64.decode64(v))`で復号できる。

    ![Rails3 ScreenShot](https://raw.github.com/miyohide/rails_girls_more_notes/master/20140301/pictures/rails3_session_key.png)

    * 上の画面では`value`欄にある「BAh7CEkiD3Nlc3Npb25faWQGOgZFVEkijTRhMTNk...」（本当はもっと長い）を変数`v`に入れ、`Marshal.load(Base64.decode64(v))`を`rails console`で実行すると`{"session_id"=>"4a13d0e1b5ddd5687f62d4fc166f9ef9", "hoge"=>"hogehgoe", "_csrf_token"=>"iHkLNz5/Hnlo99Iu9nEFeLZLgSfD55H3NvS+MDKWQNY="}`が得られる。
    * これは画面に表示させてある`session_id`や`Controller`の`index`アクションで設定したsessionの情報が表示される。
    * ソースは[rails3_scaffold](https://github.com/miyohide/rails_girls_more_notes/tree/master/20140301/rails3_scaffold)を参照。

    * Rails4では同じ方法では復号できません。（`TypeError: incompatible marshal file format (can't be read)`と出てしまいます。）
    * ソースは[rails4_scaffold](https://github.com/miyohide/rails_girls_more_notes/tree/master/20140301/rails4_scaffold)を参照。

* こういうことがどのように危険なのかは、「徳丸本」こと「体系的に学ぶ安全なWebアプリケーションの作り方」を参考にされると良いかと。
  * 徳丸本にはAmazonでKindle版もありますが、[達人出版会でDRMなしのPDF版](http://tatsu-zine.com/books/sbcr-taiketekinimanabu)が手に入ります。

* Railsに特化したものでは、[Ruby on Rails Security Guide](http://guides.rubyonrails.org/security.html)を参照されることをオススメします。

* Railsのセキュリティホールが突かれて、問題になったことはある？
  * ある。詳細は[github の mass assignment 脆弱性が突かれた件](http://blog.sorah.jp/2012/03/05/mass-assignment-vulnerability-in-github)を見てみましょう。

## 管理画面

* 管理画面について、次の2案で議論になったことがある。どっちがよい？
  * 管理者権限を持った人が管理画面へのリンクを表示させる。権限がない人は、管理画面へのリンクを表示させない。
  * 管理画面は別URLで用意し、そのURLにアクセスするとユーザID・パスワードを入力して操作させる。
* 個人的には両方を合わせたもの。
  * リンクの表示／非表示の切り替えをしても、結局はURLでアクセスできるので、権限の有無でアクセス制御はする必要がある。
  * ただ、管理画面へのアクセスのために別ユーザIDとパスワードを用意するのは運用上手間なので、ユーザに権限情報を持たせる必要がある。
  * 権限管理などを実装するのは、Rails3の時代は[cancan](https://github.com/ryanb/cancan)があったが、Rails4には対応できていない。
  * Rails4に対応できているgemは[pundit](https://github.com/elabs/pundit)や[Authority](https://github.com/nathanl/authority)を試してみてはいかがでしょう。

## OR Mapperについて

* ActiveRecordがあれば、データベースは不要じゃない？ファイルとかで十分では？
  * ActiveRecordの裏にあるデータベースは、（整理された）データの検索・更新・削除については非常に高速に行える。
  * また、データの追加・更新・削除処理などを抜け・漏れ・矛盾なく行えるようにするには、ファイルでは不十分。
  * ActiveRecordは数々あるデータベースに対して、その違いを意識することなく、データの検索・追加・更新・削除処理ができる。

## Railsの勉強について
  * いわゆる電車本こと[RailsによるアジャイルWebアプリケーション開発 第4版](http://www.amazon.co.jp/dp/4274068668)が定番。
    * 電車本はRails3.1がベース。なので、現在の最新バージョンとはいろいろ違うけど、それが勉強になることもある。
    * Railsのバージョンが違ってもやってみてはいかがでしょう。
  * 最新バージョン（Rails4）に対応しているものとしては、原書である[Agile Web Development with Rails 4](http://pragprog.com/book/rails4/agile-web-development-with-rails-4)を読むことをオススメします。

