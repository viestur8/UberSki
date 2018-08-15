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
    redirect '/blogposts'
  else
    erb :signup
  end
end

#display blog posts
get '/blogposts' do
  @users = User.all
  erb :blogposts
end

# displays sign in form
get '/signin' do
  erb :signin
end

# responds to sign in form
post "/signin" do
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
    redirect "/blogposts"
  end
end

# displays signup form
#   with fields for relevant user information like:
#   username, password
get "/signup" do
  erb :signup
end



post "/signup" do
  user = User.create(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    birthday: params[:birthday],
    username: params[:username],
    password: params[:password]
  )

  # this line does the signing in
  session[:user_id] = user.id

  # lets the user know they have signed up
  flash[:info] = "Thank you for signing up"

  # assuming this page exists
  redirect "/users"
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

#create a post
get "/createform" do
  erb :createform
end

post "/createpost" do
    @user = session[:user_id]
    Post.create(title: params[:title], post: params[:post], timestamp: DateTime.now , user_id: @user)
    redirect "/blogposts"
end
