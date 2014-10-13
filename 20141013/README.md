# 実施日時

2014年10月13日（祝）11:00-16:00 万葉にて。

# やりたいこと・やったこと

* [RailsTutorial](http://railstutorial.jp/)をはじめから
  * 今日は第1章の1.4の前までと第2章の2.1.1の前まで
* 環境はWindows上に構築したVMware + Ubuntu 14.04 + rbenv

## Ubuntu上でキーボードの刻印通りに入力できない（"とか_とか）。

* Ubuntuの環境設定にてキーボードの設定が日本語になっていないのが原因のように思われます。
* [ここのサイト](http://www.mazn.net/blog/2014/07/06/1356.html)に記載されている内容を参考にコマンドを打ってみる。
  * `dpkg-reconfigure keyboard-configuration` というコマンド。
  * `dpkg-reconfigure keyboard-configuration` コマンドを打つときは、前に「sudo」を追加する必要がありました（管理者権限で実行したいため）。つまり、 `sudo dpkg-reconfigure keyboard-configuration`と実行する必要があり。

## sublコマンドを使いたい

* RailsTutorialの中で出てくるsublコマンドを使いたいです。
* [Rails Tutorial Sublime Text setup](https://github.com/mhartl/rails_tutorial_sublime_text)をみて対応します。
* Sublimeを `~/Documents/sublime Text 2/`においたら、次のコマンドを打つことで使えるようになります。
  * `sudo ln -s ~/Documents/Sublime\ Text\ 2/sublime_text /usr/bin/subl`

## rails server実行時に変なメッセージが出てしまう

* JavaScriptを処理するためのエンジンがインストールされていないため、起こってしまう現象です。
* 対策方法は色々とありますが、今回はNode.jsというものを入れることで解決します。
* Ubuntuでは、apt-getでインストールが出来ます。
  * `sudo apt-get update`でインストールできるソフトウェアの最新のリストを取得して、`sudo apt-get install nodejs`でインストールできます。

## Gitのブランチ、変更、コミット、マージについて

* Gitというソフトウェアを使えば、ファイルの変更（削除も！）を無かったことにしたりすることができます（1.3.3「Gitのメリット」に記載されていることですね）。
* ブランチ（今回は、`modify-README`という名前のブランチ）は、変更するための新しい作業場所を作っているというイメージになります。
* ブランチで行った変更は、他のブランチには影響を与えません。今回の例で言えば、`modify-README`で行った変更は、`master`には反映されていません。
* `modify-README`で行った変更を`master`に反映させるためには、マージという作業を行います。

## Herokuへのデプロイについて

* Railstutorialでは、Herokuへのデプロイを行っていますが、RailsGirls, Moreでやったように、MOGOKへのデプロイもできます。
* Herokuへのデプロイはアカウント作成やデプロイ作業にちょっと時間がかかるので、今日は飛ばします。
* 日本語で詳細に書かれている本としては、[プロフェッショナルのための 実践Heroku入門 プラットフォーム・クラウドを活用したアプリケーション開発と運用](http://www.amazon.co.jp/gp/product/4048915134/)などを見てみてはいかがでしょう。


