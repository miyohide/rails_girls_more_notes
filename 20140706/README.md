# 実施日付

2014年7月6日（日）11:00-16:00 万葉にて。

# やりたいこと・やったこと

* メタプログラミングRubyを読んでいて躓いていたところを教えて欲しい

## 同じ文字列が2度出力される

* 次のようなコードで同じ文字列が2度出力されるのはなぜ？

```ruby
class MyStand
   def pucci
      @stand = "WhiteSnake"
      p @stand + " 1回目"
   end
end

obj = MyStand.new
p obj.pucci
```

これを実行すると、

```
WhiteSnake 1回目
WhiteSnake 1回目
```

という風に2回出力されてしまう。

* 原因は、`p`メソッドが引数を戻り値として返してしまうから。[マニュアル](http://docs.ruby-lang.org/ja/2.1.0/method/Kernel/m/p.html)
* 例えば、`p obj.pucci`の部分を`obj.pucci`に修正すればよいです。

```ruby
class MyStand
   def pucci
      @stand = "WhiteSnake"
      p @stand + " 1回目"
   end
end

obj = MyStand.new
obj.pucci
```

## 特異クラスとか特異メソッドとかの使い道

* まずは特異クラスとか特異メソッドとかの復習。
  * [特異クラス](http://docs.ruby-lang.org/ja/2.1.0/doc/spec=2fdef.html#singleton_class)
  * [特異メソッド](http://docs.ruby-lang.org/ja/2.1.0/doc/spec=2fdef.html#singleton_method)
  * [るびまの記事](http://magazine.rubyist.net/?0046-SingletonClassForBeginners)もご参考に。
* ライブラリ作成の用途以外にあまり特異クラスとか特異メソッドとかの使い道について思いつきませんでした。すみませんm(_ _)m

## 定数の参照について

* 定数の参照については、[::](http://docs.ruby-lang.org/ja/2.1.0/doc/spec=2fvariables.html#const)演算子を使います。
* 定数は先頭が大文字で始まっていたら定数です。
  * ちなみに、クラス名やモジュール名は、先頭が大文字で始まっているので、定数です。

```ruby
[1] pry(main)> class hoge ; end
SyntaxError: (eval):2: class/module name must be CONSTANT
class hoge ; end
            ^
[1] pry(main)>
```

* こういう`::`のような記号って検索しにくい。言語ごとに微妙に使い方が違うし。
  * チートシートみたいなものがあったらいいのに。

