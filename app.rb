# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'cgi'

DETA_STORAGE = 'public/deta.json'

def fetch_memos
  JSON.parse(File.read(DETA_STORAGE))
end

def update_memos(memos)
  File.open(DETA_STORAGE, 'w') do |file|
    JSON.dump(memos, file)
  end
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

get '/memos' do
  @memos = fetch_memos
  erb :index
end

get '/memos/new' do
  erb :new
end

get '/memos/:id' do
  memos = fetch_memos
  @title = memos[params[:id]]['title']
  @content = memos[params[:id]]['content']
  erb :show
end

get '/memos/:id/edit' do
  memos = fetch_memos
  @title = memos[params[:id]]['title']
  @content = memos[params[:id]]['content']
  erb :edit
end

post '/memos' do
  title = params[:title]
  content = params[:content]

  memos = fetch_memos
  id = (memos.keys.map(&:to_i).max.to_i + 1).to_s
  memos[id] = { 'title' => title, 'content' => content }
  update_memos(memos)

  redirect '/memos'
end

patch '/memos/:id' do
  title = params[:title]
  content = params[:content]

  memos = fetch_memos
  memos[params[:id]] = { 'title' => title, 'content' => content }
  update_memos(memos)

  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  memos = fetch_memos
  memos.delete(params[:id])
  update_memos(memos)

  redirect '/memos'
end
