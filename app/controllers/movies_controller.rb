# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
    def index
      @movies = Movie.all
    end

    def show
        id = params[:id] # retrieve movie ID from URI route
        @movie = Movie.find(id) # look up movie by unique ID
        # will render app/views/movies/show.html.haml by default
    end

    def new
        @movie = Movie.new
    end

    def create
        @movie = Movie.new(movie_params)
        if @movie.save
          flash[:notice] = "#{@movie.title} was successfully created."
          redirect_to movie_path(@movie)
        else
          render 'new' # note, 'new' template can access @movie's field values!
        end
    end

    def edit
        @movie = Movie.find params[:id]
    end

    def update
        @movie = Movie.find params[:id]
        if @movie.update_attributes(params[:movie])
          flash[:notice] = "#{@movie.title} was successfully updated."
          redirect_to movie_path(@movie)
        else
          render 'edit' # note, 'edit' template can access @movie's field values!
        end
    end

    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
        flash[:notice] = "Movie '#{@movie.title}' deleted."
        redirect_to movies_path
    end

    private
      def movie_params
        params.require(:movie).permit(:title, :rating, :release_date)
      end

  end