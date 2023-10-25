# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'cgi'

def connection
  PG.connect(dbname: 'memoapp')
end

configure do
  connection.exec('CREATE TABLE IF NOT EXISTS memos (id serial PRIMARY KEY, title text, content text)')
end

def fetch_memo(id)
  result = connection.exec_params('SELECT * FROM memos WHERE id = $1;', [id])
  result[0]
end

get '/memos' do
  @memos = connection.exec('SELECT * FROM memos ORDER BY id ASC')
  erb :index
end

get '/memos/new' do
  erb :new
end

get '/memos/:id' do
  @memo = fetch_memo(params[:id])
  erb :show
end

get '/memos/:id/edit' do
  @memo = fetch_memo(params[:id])
  erb :edit
end

post '/memos' do
  title = params[:title]
  content = params[:content]

  result = connection.exec_params('INSERT INTO memos (title, content) VALUES ($1, $2) RETURNING id', [title, content])
  id = result[0]['id']

  redirect "/memos/#{id}"
end

patch '/memos/:id' do
  title = params[:title]
  content = params[:content]
  id = params[:id]

  connection.exec_params('UPDATE memos SET title = $1, content = $2 WHERE id = $3;', [title, content, id])

  redirect "/memos/#{id}"
end

delete '/memos/:id' do
  id = params[:id]

  connection.exec_params('DELETE FROM memos WHERE id = $1;', [id])

  redirect '/memos'
end
