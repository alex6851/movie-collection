class MoviesController < ApplicationController




  # GET: /movies/new
  get "/movies/new" do
    if logged_in?
      @genres = Genre.all
      erb :'/movies/new.html'
    else
    redirect '/login'
    end
  end

  # POST: /movies
  post '/movies' do
    if logged_in?
      if params[:movie][:name] == ""
        redirect to "/movies/new"
      else
        @movie = current_user.movies.build(name: params[:movie][:name])
        if Genre.find_by_id(params["genre"]["genre_id"])
          @movie.genre = Genre.find_by_id(params["genre"]["genre_id"])
        else 
          @movie.genre = Genre.create(name: params["genre"]["name"])
        end
        if @movie.save
          redirect to "/movies/#{@movie.id}"
        else
          redirect to "/movies/new"
        end
      end
    else
      redirect to '/login'
    end
  end


  # GET: /movies/5
  get '/movies/:id' do
    if logged_in?
      @movie = Movie.find_by_id(params[:id])
      erb :'movies/show.html'
    else
      redirect to '/login'
    end
  end

  # GET: /movies/5/edit
  get '/movies/:id/edit' do
    if logged_in?
      @movie = Movie.find_by_id(params[:id])
      @genres = Genre.all
      if @movie && @movie.user == current_user
        erb :'movies/edit.html'
      else
        redirect to '/movies'
      end
    else
      redirect to '/login'
    end
  end

  # PATCH: /movies/5
  patch "/movies/:id" do
    if logged_in?
      if params[:name] == ""
        redirect to "/movies/#{params[:id]}/edit"
      else
        @movie = Movie.find_by_id(params[:id])
        if @movie && @movie.user == current_user
          #Trying to edit movie's genre with a selection of existing genres
          # if Genre.find_by_id(params["genre"]["genre_id"])  
          #   @genre = Genre.find_by_id(params["genre"]["genre_id"])
          #   @movie.genre.update(name: @genre.name)
          # end
          if @movie.update(name: params[:name])
            redirect to "/movies/#{@movie.id}"
          else
            redirect to "/movies/#{@movie.id}/edit"
          end
        else
          redirect to '/movies'
        end
      end
    else
      redirect to '/login'
    end
  end

  # DELETE: /movies/5/delete
  delete '/movies/:id/delete' do
    if logged_in?
      @movie = Movie.find_by_id(params[:id])
      if @movie && @movie.user == current_user
        @movie.delete
      end
      redirect to '/movies'
    else
      redirect to '/login'
    end
  end

  get "/movies" do
    if logged_in?
      @movies = Movie.all
    erb :"/movies/index.html"
    else
      redirect '/login'
    end
  end





end