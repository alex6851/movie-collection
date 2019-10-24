class UsersController < ApplicationController

  # GET: /users


  get '/signup' do
    if !logged_in?
      erb :'users/new.html'
    else
      redirect to '/movies'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :password => params[:password])
      @user.slug = @user.slug
      @user.save
      session[:user_id] = @user.id
      redirect to '/movies'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login.html'
    else
      redirect to '/movies'
    end
  end


  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/movies"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    binding.pry
    erb :'users/show.html'
  end

end