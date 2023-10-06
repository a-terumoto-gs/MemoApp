# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'cgi'

def connect_db
  @connect = PG.connect(dbname: 'MemoApp')
end

before do
  connect_db
end

configure do
  result = @connect&.exec("SELECT * FROM information_schema.tables WHERE table_name = 'memos'")
  @connect.exec('CREATE TABLE memos (id serial, title varchar(255), content text)') if result.values.empty?
end

def fetch_memo(id)
  result = @connect.exec_params('SELECT * FROM memos WHERE id = $1;', [id])
  result.tuple_values(0)
end

get '/memos' do
  @memos = @connect&.exec('SELECT * FROM memos')
  erb :index
end

get '/memos/new' do
  erb :new
end

get '/memos/:id' do
  memo = fetch_memo(params[:id])
  @title = memo[1]
  @content = memo[2]
  erb :show
end

get '/memos/:id/edit' do
  memos = fetch_memo(params[:id])
  @title = memos[1]
  @content = memos[2]
  erb :edit
end

post '/memos' do
  title = params[:title]
  content = params[:content]

  @connect.exec_params('INSERT INTO memos(title, content) VALUES ($1, $2);', [title, content])

  redirect '/memos'
end

patch '/memos/:id' do
  title = params[:title]
  content = params[:content]
  id = params[:id]

  @connect.exec_params('UPDATE memos SET title = $1, content = $2 WHERE id = $3;', [title, content, id])

  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  id = params[id]
  @connect.exec_params('DELETE FROM memos WHERE id = $1;', [id])

  redirect '/memos'
end
