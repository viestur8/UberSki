require 'sinatra'
require 'sinatra/activerecord'
require "sinatra/flash"
require './models/user'
require './models/blogpost'

enable :sessions

set :database, {adapter: "postgresql", database: "ski_blog"}

# Display homepage
get '/' do
  if session[:user_id]
    erb :sign_in
  else
    erb :sign_in
  end
end

# displays sign in form
  get '/sign-in' do
    erb :sign_in
  end

  # responds to sign in form
post "/sign-in" do
  @user = User.find_by(username: params[:username])
  if @user && @user.password == params[:password]
      # this line signs a user in
      session[:user_id] = @user.id

      # lets the user know that something is wrong
      flash[:info] = "You have been signed in"

      # redirects to the home page
      redirect "/"
    else
      # lets the user know that something is wrong
      flash[:warning] = "Your username or password is incorrect"

      # if user does not exist or password does not match then
      #   redirect the user to the sign in page
      redirect "/sign-in"
    end
  end

  # displays signup form
#   with fields for relevant user information like:
#   username, password
get "/sign-up" do
  erb :sign_up
end



post "/sign-up" do
  @user = User.create(
    username: params[:username],
    password: params[:password]
  )
  # this line does the signing in
  session[:user_id] = @user.id

  # lets the user know they have signed up
  flash[:info] = "Thank you for signing up"

  # assuming this page exists
  redirect "/"
end

# when hitting this get path via a link
#   it would reset the session user_id and redirect
#   back to the homepage
  get "/sign-out" do
  # this is the line that signs a user out
  session[:user_id] = nil

  # lets the user know they have signed out
    flash[:info] = "You have been signed out"
    redirect "/"
    end
