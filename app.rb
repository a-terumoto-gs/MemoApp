# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'cgi'

def connect
  @connect ||= PG.connect(dbname: 'MemoApp')
end

before do
  connect
end

configure do
  @connect&.exec('CREATE TABLE IF NOT EXISTS memos (id serial, title varchar, content text)')
end

def fetch_memo(id)
  result = @connect.exec_params('SELECT * FROM memos WHERE id = $1;', [id])
  result[0]
end

get '/memos' do
  @memos = @connect.exec('SELECT * FROM memos ORDER BY id ASC')
  erb :index
end

get '/memos/new' do
  erb :new
end

get '/memos/:id' do
  memo = fetch_memo(params[:id])
  @memo = {
    title: memo['title'],
    content: memo['content']
  }
  erb :show
end

get '/memos/:id/edit' do
  memo = fetch_memo(params[:id])
  @memo = {
    title: memo['title'],
    content: memo['content']
  }
  erb :edit
end

post '/memos' do
  title = params[:title]
  content = params[:content]

  @connect.exec_params('INSERT INTO memos(title, content) VALUES ($1, $2);', [title, content])

  result = @connect.exec('SELECT lastval()')
  id = result[0]['lastval']

  redirect "/memos/#{id}"
end

patch '/memos/:id' do
  title = params[:title]
  content = params[:content]
  id = params[:id]

  @connect.exec_params('UPDATE memos SET title = $1, content = $2 WHERE id = $3;', [title, content, id])

  redirect "/memos/#{id}"
end

delete '/memos/:id' do
  id = params[:id]

  @connect.exec_params('DELETE FROM memos WHERE id = $1;', [id])

  redirect '/memos'
end
