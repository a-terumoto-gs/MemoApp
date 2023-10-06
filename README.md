## このアプリについて
ブラウザで使えるメモアプリです
主な機能は以下の通りです
- メモの追加、編集、削除
- メモ一覧の表示

## このアプリケーションの立ち上げ方
1. GitHubからリポジトリを`git clone`でローカルに取り込む
2.リポジトリ`MemoApp`に移動
3.`bundle install`を実行し、必要な`gem`のインストールを行う
4.  `create -U ユーザー名 -d MemoApp`を実行し、DB`MemoApp`を作成
5.`bundle exec ruby memoapp.rb`を実行
6.ブラウザで`http://localhost:4567/memos`にアクセスする
