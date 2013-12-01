# 実施日付

2013年12月1日（日）11:00-16:00 万葉にて。

# やりたいこと

* 何かAPIを叩いて、カッコイイサイトを作りたいです。
  * Google Map APIを叩いてみて、地図を表示するようにしたいです。

## Google Map APIの使い方

### 1. RubyGemsの調査

* Google検索を行うと、[Google-Maps-for-Rails](https://github.com/apneadiving/Google-Maps-for-Rails)が引っかかり、それを使ったサンプルアプリを紹介しているサイト[RailsでGoogle Mapを使ってみる～Google-Maps-for-Rails](http://blog.scimpr.com/2012/09/10/rails%E3%81%A7google-map%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B%EF%BD%9Egoogle-maps-for-rails/)もありましたので、サイトの記述を元に作業を進めることにしました。

### 2. プロジェクトの作成

```ruby
rails new gmap
```

### 3. scaffold

```ruby
rails g scaffold person name address
```

でnameカラムとaddressカラムをもつpersonを持つものを生成して、`migration`を行います。

```ruby
rake db:migrate
```

### 4. Gemのインストール

Gemfileに`gem 'gmaps4rails'`を追加して、`bundle install`を行います。

この時、Production環境ではPostgreSQLを使いたいが、開発環境ではPostgreSQLを入れたくない場合、`bundle install`実行時にエラーが出てしまうことがあります。この時は、

`bundle install --without production`

を実行すると、Production環境以外のGemがインストールされます。

### 5. JavaScriptとCSSの説明

サイトには、`rails g gmaps4rails:install`を実行すると書かれていたけど、これが上手く動かないorz。その他、model内に追加した`acts_as_gmappable`も上手く動かなかったので、今後の方針を考える。

### 6. 方針変更

[Google-Maps-for-Rails](https://github.com/apneadiving/Google-Maps-for-Rails)のReadmeに記載の内容と[チュートリアルビデオ](https://www.youtube.com/watch?v=R0l-7en3dUw&feature=youtu.be)に基づいて、作業を進めていくことにする。

### 7. geocoderの導入

地名やランドマーク名から緯度・経度を求めるGemであるgeocoderをGemfileに追加して、bundle installを行います。

### 8. Google Mapの表示位置を設定

viewにGoogle Mapを表示する位置を設定します。今回は、`app/views/people/index.html.erb`に対して、Google Mapを表示したい場所に次のプログラムを追加します。

```HTML
<div style='width: 800px;'>
  <div id="map" style='width: 800px; height: 400px;'></div>
</div>
```

### 9. ライブラリのJavaScriptコードの追加

ライブラリのJavaScriptコードを追加します。まずは、インターネット上にあるJavaScriptコードに対してリンクを張ります。`app/views/layouts/application.html.erb`に対して、以下の2行を追加します。

```HTML
<script src="//maps.google.com/maps/api/js?v=3.13&amp;sensor=false&amp;libraries=geometry" type="text/javascript"></script>
<script src='//google-maps-utility-library-v3.googlecode.com/svn/tags/markerclustererplus/2.0.14/src/markerclusterer_packed.js' type='text/javascript'></script>
```

次に、[Google-Maps-for-Rails](https://github.com/apneadiving/Google-Maps-for-Rails)が提供しているライブラリ名と、依存しているライブラリ名[underscore.js](http://underscorejs.org/)を`app/assets/javascripts/application.js`に記載します。

```JavaScript
//= require underscore
//= require gmaps/google
```

[underscore.js](http://underscorejs.org/)は、サイトからダウンロードし、`app/assets/javascripts/`や`vendor/assets/javascripts/`以下に格納します。外部ライブラリなどは`vendor/assets/javascripts/`以下に格納するのがよいでしょう。

### 10. modelの修正

`app/models/person.rb`に対して以下の2行を追加します。

```ruby
   geocoded_by :address
   after_validation :geocode
```

この2行は`address`に入力された住所やスポット名から`latitude`・`longitude`（緯度・経度）を求める処理を行っています。

この時点でPersonにデータを入力すると、`address`の値から`latitude`・`longitude`の値が求められ、データベースに設定されることが確認できます。

### 11. viewにGoogle Mapを表示させる（固定値で緯度・経度が0、0の位置）

次に、`app/views/people/index.html.erb`に対して次のJavaScriptプログラムを挿入します。

```JavaScript
<script type='text/javascript'>
handler = Gmaps.build('Google');
handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
  markers = handler.addMarkers([
    {
      "lat": 0,
      "lng": 0,
      "picture": {
        "url": "https://addons.cdn.mozilla.net/img/uploads/addon_icons/13/13028-64.png",
        "width":  36,
        "height": 36
      },
      "infowindow": "hello!"
    }
  ]);
  handler.bounds.extendWith(markers);
  handler.fitMapToBounds();
});
</script>
```

上記のプログラムの中で、`"lat": 0,`と`"lng": 0,`の記載があることから、ここでは入力されたデータによらず、緯度・経度が0・0の位置を示します。ただ、これでライブラリのインストールが上手くできていることが確認できるでしょう。

### 12. 表示位置をそれぞれの人の登録情報に合わせる

上記までは緯度・経度が0・0のものを指していましたので、ここでは、登録されている人（person）の位置（address）をGoogle Mapに表示させましょう。そのための対応には、まず、`app/controllers/people_controller.rb`の`index`アクションを編集します。

```ruby
  def index
    @people = Person.all
    @hash = Gmaps4rails.build_markers(@people) do |person, marker|
       marker.lat person.latitude
       marker.lng person.longitude
    end
  end
```

もともとある`@people = Person.all`の下の行に`@hash`を生成する処理を追加します。

その後、`app/views/people/index.html.erb`に対して、上記で追加したJavaScriptを下記のように修正します（markersの部分です）。

```JavaScript
<script type='text/javascript'>
handler = Gmaps.build('Google');
handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
  markers = handler.addMarkers(<%=raw @hash.to_json %>);
  handler.bounds.extendWith(markers);
  handler.fitMapToBounds();
});
</script>
```

これで、自分が入力したデータをGoogle Mapに反映することが出来ました。

## 今後について

* Rails関連書籍は、[RailsTutorial](http://railstutorial.jp/)が良いかと思う。
* RubyGemの検索については、[The Ruby Toolbox](https://www.ruby-toolbox.com/)を活用されると良いでしょう。何らかのAPIを使いたい時に、更に使いやすくしてくれるGemがあるかもしれません。
* 実際にGemの使ってみた例は[RailsCasts](http://railscasts.com/)が参考になるかと思います。[RailsCasts](http://railscasts.com/)をテキスト化したAsciiCastsも合わせて活用されると良いかもしれません。
* RubyやRailsの最新情報や使えるGemの情報は、[Ruby5](http://ruby5.envylabs.com/)というPodcastsを聞いてみてサイトを訪れてみると良いかと思います。

# 今日、他の人達がやったこと

* t-wadaさんのRSpec記事である[RSpec の入門とその一歩先へ](http://d.hatena.ne.jp/t-wada/20100228/p1)を読み進めていました。
* [ザ・インタビューズが閉鎖](http://theinterviews.jp/update/71)してしまうので、その前にお気に入りの人の回答データを取得するプログラムを作ってました。

