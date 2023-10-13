## このアプリについて
ブラウザで使えるメモアプリです
主な機能は以下の通りです
- メモの追加、編集、削除
- メモ一覧の表示

## このアプリケーションの立ち上げ方
1. GitHubからリポジトリを`git clone`でローカルに取り込む
2. リポジトリ`MemoApp`に移動
3. `git checkout dev-db`を実行し`main`ブランチから`dev-db`ブランチに移動
4. `bundle install`を実行し、必要な`gem`のインストールを行う
5. `sudo service postgresql start`でPostgreSQLサーバーを起動
6. `psql postgres`でpostgresユーザでログイン(6,7はpostgres内での操作)
7. `create database MemoApp;`でDBを作成
8. `\q`でpostgresから抜ける
9. `bundle exec ruby app.rb`を実行
10. ブラウザで`http://localhost:4567/memos`にアクセスする
