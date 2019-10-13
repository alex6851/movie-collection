class GenresController < ApplicationController
    get "/genres/new" do
        if logged_in?
          @movies = Movie.all
          @genres = Genre.all
          erb :'/genres/new.html'
        else
        redirect '/login'
        end
      end
    
      # POST: /genres
      post '/genres' do
        if logged_in?
          if params[:name] == ""
            redirect to "/genres/new"
          else
            @genre = current_user.genres.build(name: params[:name])
            if @genre.save
              redirect to "/genres/#{@genre.id}"
            else
              redirect to "/genres/new"
            end
          end
        else
          redirect to '/login'
        end
      end
    
    
      # GET: /genres/5
      get '/genres/:id' do
        if logged_in?
          @genre = genre.find_by_id(params[:id])
          erb :'genres/show.html'
        else
          redirect to '/login'
        end
      end
    
      # GET: /genres/5/edit
      get '/genres/:id/edit' do
        if logged_in?
          @genre = Genre.find_by_id(params[:id])
          if @genre && @genre.user == current_user
            erb :'genres/edit.html'
          else
            redirect to '/genres'
          end
        else
          redirect to '/login'
        end
      end
    
      # PATCH: /genres/5
      patch "/genres/:id" do
        if logged_in?
          if params[:name] == ""
            redirect to "/genres/#{params[:id]}/edit"
          else
            @genre = genre.find_by_id(params[:id])
            if @genre && @genre.user == current_user
              if @genre.update(name: params[:name])
                redirect to "/genres/#{@genre.id}"
              else
                redirect to "/genres/#{@genre.id}/edit"
              end
            else
              redirect to '/genres'
            end
          end
        else
          redirect to '/login'
        end
      end
    
      # DELETE: /genres/5/delete
      delete '/genres/:id/delete' do
        if logged_in?
          @genre = genre.find_by_id(params[:id])
          if @genre && @genre.user == current_user
            @genre.delete
          end
          redirect to '/genres'
        else
          redirect to '/login'
        end
      end
    
      get "/genres" do
        if logged_in?
          @genres = genre.all
        erb :"/genres/index.html"
        else
          redirect '/login'
        end
end