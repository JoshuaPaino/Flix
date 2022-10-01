class MoviesController < ApplicationController

    before_action :set_movie, only: [:show, :edit, :update, :destroy]
    before_action :require_signin, except: [:index, :show]
    before_action :require_admin, except: [:index, :show]

    def index
        case params[:filter]
        when "upcoming"
          @movies = Movie.upcoming
        when "recent"
          @movies = Movie.recent
        else
          @movies = Movie.released
        end
    end

    def show
        @fans = @movie.fans
        @genres = @movie.genres.order(:name)
        if current_user
            @favorite = current_user.favorites.find_by(movie_id: @movie.id)
          end
    end

    def edit
    end

    def update
        if @movie.update(movie_params) 
        redirect_to movie_path(@movie), notice: "Movie successfully updated" 
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def new
        @movie = Movie.new
    end

    def create
        @movie = Movie.new(movie_params)
       if @movie.save
        redirect_to @movie, notice: "Movie successfully Created" 
       else
        render :new, status: :unprocessable_entity
       end
    end

    def destroy
        @movie.destroy
        redirect_to movies_path, status: :see_other
    end
private
    def movie_params
            params.require(:movie).
                permit(:title, :description, :rating, :released_on, :total_gross,:director ,:duration, :image_file_name, genre_ids: [])
    end
    def set_movie
        @movie = Movie.find_by!(slug: params[:id])
    end
end
