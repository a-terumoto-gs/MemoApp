## このアプリについて
ブラウザで使えるメモアプリです
主な機能は以下の通りです
- メモの追加、編集、削除
- メモ一覧の表示

## このアプリケーションの立ち上げ方
1.GitHubからリポジトリを`git clone`でローカルに取り込む
2.リポジトリ`MemoApp`に移動
3.`bundle install`を実行し、必要な`gem`のインストールを行う
4.`sudo service postgresql start`でPostgreSQLサーバーを起動
5.`psql postgres`でpostgresユーザでログイン(6,7はpostgres内での操作)
6.`create database MemoApp`でDBを作成
7.`\q`でpostgresから抜ける
8.`bundle exec ruby app.rb`を実行
9.ブラウザで`http://localhost:4567/memos`にアクセスする
