require 'sinatra'
require 'sinatra/activerecord'
require "sinatra/flash"
require './models/user'
require './models/blogpost'

enable :sessions



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
  @post = Post.all
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
    redirect "/blogposts"
  else
    # lets the user know that something is wrong
    flash[:warning] = "Your username or password is incorrect"

    # if user does not exist or password does not match then
    #   redirect the user to the sign in page
    redirect "/signin"
  end
end

# displays signup form
#   with all fields for user fill in
get "/signup" do
  erb :signup
end

#Here that info is being collected.
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
  redirect "/blogposts"
end

# when hitting this get path via a link
#   it would reset the session user_id and redirect
#   back to the homepage
get "/signout" do
  # this is the line that signs a user out
  session[:user_id] = nil
  # lets the user know they have signed out
  flash[:info] = "You have been signed out"
  redirect "/signup"
end

#Show all users
get '/users' do
  @users= User.all
  erb :users
end
#create a post
get "/write" do
  if session[:user_id]
    erb :createform
  else
    flash[:info] = "Please Sign Up to post to the blog"
    erb :signup
  end
end

post "/post" do
    @user = session[:user_id]
    Post.create(title: params[:title], post: params[:post], timestamp: DateTime.now , user_id: session[:user_id])

    redirect "/blogposts"
end

  get '/profile' do
    @specific_user = User.find(params[:id])
    erb :profile
  end

get '/blogposts/:id/edit' do  #load edit form
  if @specific_user = User.find(params[:id])
    @post = Post.find_by_id(params[:id])
    erb :edit
  else
    flash[:info] = "User may edit only one's posts"
    erb :blogposts
  end
end

get '/blogposts/:id' do
  @post = Post.find(params[:id])
  erb :post
end

patch '/blogposts/:id' do #edit action
  @post = Post.find_by_id(params[:id])
  @post.title = params[:title]
  @post.post = params[:post]
  @post.save
  redirect "/blogposts"
end

get '/about' do
  erb :about
end

put '/users/:id' do
    @current_user = User.find(params[:id])
    @current_user.update(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    birthday: params[:birthday],
    username: params[:username],
    password: params[:password]
  )
    end

get '/users/:id' do
    #show all posts that belong to a specific user
    @specific_user = User.find(params[:id])
    @users_posts = @specific_user.posts
      erb :specific_user
end

#Let's delete a blogpost

delete '/blogposts/:id' do #delete action
  if session[:user_id]
    @article = Post.find_by_id(params[:id])
    @article.delete
      redirect to '/blogposts'
  else
      flash[:info] = "Please Sign Up to post to the blog"
      erb :signup
  end
  delete '/users/:id' do #delete action
    if session[:user_id]
      @user = User.find_by_id(params[:id])
      @user.delete
        redirect to '/blogposts'
    else
        flash[:info] = "Please Sign Up to post to the blog"
        erb :signup
    end
end
end
