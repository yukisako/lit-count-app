require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models/count.rb'

before do
  if Count.all.size == 0
    Count.create(number: 0)
  end
  count = Count.first
  if count.number > 10000 || count.number < -10000
    count.number = 0
    count.save
  end
end

get '/' do
  redirect 'count'
end

get '/count' do
  @number = Count.first.number
  @hoge = Count.first
  erb :index
end

post '/plus' do
  count = Count.first
  count.number = count.number + 1
  count.save
  redirect '/count'
end

post '/minus' do
  count = Count.first
  count.number = count.number - 1
  count.save
  redirect '/count'  
end

post '/times' do
  count = Count.first
  count.number = count.number * 2

  count.save
  redirect '/count'
end