class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    render :index
  end

  def show
    @movie = movie.find_by(id: params[:id])
    render :show
  end

  def create
  @movie = Movie.new(
    name: params[:name],
    movie_url: params[:movie_url],
    poster: params[:poster],
    overview: params[:overview],
    actors: params[:actors],
    rating: params[:rating],
    user_rating: params[:user_rating],
    release_date: params[:release_date],
    run_time: params[:run_time]
  )

    if @movie.save
      # Handle genres safely, whether they come as string or array
      if params[:genres].present?
        genre_names = Array(params[:genres])

        # If a single comma-separated string, split into array
        if genre_names.size == 1 && genre_names.first.is_a?(String)
          genre_names = genre_names.first.split(",").map(&:strip)
        

          genre_names.each do |genre_name|
            genre = Genre.find_or_create_by(name: genre_name)
            @movie.genres << genre unless @movie.genres.include?(genre)
          end
        end

        render :show, status: :created
      else
        render json: { errors: @movie.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update(
      name: params[:name],
      movie_url: params[:movie_url],
      poster: params[:poster],
      overview: params[:overview],
      actors: params[:actors],
      rating: params[:rating],
      user_rating: params[:user_rating],
      release_date: params[:release_date],
      run_time: params[:run_time]
    )
      # Handle genres safely
      if params[:genres].present?
        genre_names = Array(params[:genres])

        # Split single string into array if needed
        if genre_names.size == 1 && genre_names.first.is_a?(String)
          genre_names = genre_names.first.split(",").map(&:strip)
        

        # Replace old genres with new ones
        genres = genre_names.map { |name| Genre.find_or_create_by(name: name) }
        @movie.genres = genres
      end

        render :show, status: :ok
      else
        render json: { errors: @movie.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @movie = Movie.find_by(id: params[:id])
    @movie.destroy
    render json: {message: "Movie was Removed Successfully"}
  end
end
