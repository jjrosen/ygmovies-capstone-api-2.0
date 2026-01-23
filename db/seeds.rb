# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create genres
genres = ["Action", "Comedy", "Drama", "Horror", "Sci-Fi", "Thriller", "Romance", "Animation"].map do |name|
  Genre.find_or_create_by!(name: name)
end

puts "Created #{Genre.count} genres"

# Create sample movies with YouTube trailer URLs
movies_data = [
  {
    name: "Inception",
    overview: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.",
    poster: "https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Ber.jpg",
    release_date: "2010-07-16",
    run_time: "2h 28m",
    rating: 9,
    user_rating: 8,
    actors: "Leonardo DiCaprio, Joseph Gordon-Levitt, Elliot Page, Tom Hardy",
    movie_url: "https://www.youtube.com/watch?v=YoHD9XEInc0",
    genre_names: ["Action", "Sci-Fi", "Thriller"]
  },
  {
    name: "The Dark Knight",
    overview: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
    poster: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
    release_date: "2008-07-18",
    run_time: "2h 32m",
    rating: 9,
    user_rating: 9,
    actors: "Christian Bale, Heath Ledger, Aaron Eckhart, Michael Caine",
    movie_url: "https://www.youtube.com/watch?v=EXeTwQWrcwY",
    genre_names: ["Action", "Drama", "Thriller"]
  }
]

movies_data.each do |movie_data|
  genre_names = movie_data.delete(:genre_names)
  movie = Movie.find_or_create_by!(name: movie_data[:name]) do |m|
    m.assign_attributes(movie_data)
  end
  
  # Associate genres
  genre_names.each do |genre_name|
    genre = Genre.find_by(name: genre_name)
    if genre && !movie.genres.include?(genre)
      movie.genres << genre
    end
  end
end

puts "Created #{Movie.count} movies"
