#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
  erb :about
end

get '/visit' do
  erb :visit
end

post '/visit' do
  @user_name = params[:username]
  @phone = params[:phone]
  @date_time = params[:date]
  @barber = params[:barber]

  f = File.open('./public/users.txt', 'a')
  f.write "Клиент:  #{@user_name}, Номер телефона:  #{@phone}, Мастер : #{@barber} Дата:  #{@date_time} \n"
  f.close

  erb :message
end

get '/contacts' do
  erb :contacts
end

post '/contacts' do
  @email = params[:email]
  @message = params[:message]

  f = File.open('./public/contacts.txt', 'a')
  f.write "Пользователь : #{@email}, пишет нам следующее : #{@message} \n"
  f.close

  erb :send
end

get '/login' do
  erb :login
end

post '/login' do
  @login = params[:login]
  @password = params[:password]

  if @login == 'admin' && @password == 'admin'
    @file = File.open('./public/users.txt', 'r')
    erb :admin
  else
    erb :user_not_found
  end
end

get '/admin' do
  @file = File.open('./public/users.txt', 'r')
  erb :admin
end