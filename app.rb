#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'

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
  @username = params[:username]
  @phone = params[:phone]
  @date = params[:date]
  @barber = params[:barber]

  hh = {
    :username => 'Введите имя',
    :phone => 'Введите телефон',
    :date => ' Введите дату и врмя'
  }

  @error = hh.select { |key, _| params[key] == "" }.values.join(", ")

  if @error != ''
    return erb :visit
  end

  erb "OK, username is #{@username}, #{@phone}, #{@date}, #{@barber}, #{@color}"

  f = File.open('./public/users.txt', 'a')
  f.write "Клиент:  #{@username}, Номер телефона:  #{@phone}, Мастер : #{@barber} Дата:  #{@date} \n"
  f.close

  erb :message
end

get '/contacts' do
  erb :contacts
end

post '/contacts' do
  @email = params[:email]
  @message = params[:message]

  hh = {
    :email => 'Введите email'
  }

  @error = hh.select { |key, _| params[key] == "" }.values.join(", ")

  if @error != ''
    return erb :contacts
  end

  Pony.mail(
    # :mail => params[:email],
    :to => 'cryprofriend@gmail.com',
    :body => params[:message],
    # :port => '587',
    :via => :smtp,
    :via_options => {
      :address => 'smtp.gmail.com',
      :port => '587',
      :enable_starttls_auto => true,
      :user_name => 'cryprofriend@gmail.com',
      :password => 'Qwe123qwe098',
      :authentication => :plain,
      :domain => 'localhost'
    })

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