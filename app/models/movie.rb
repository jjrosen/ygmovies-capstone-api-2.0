class Movie < ApplicationRecord
  has_many :movie_genres
  has_many :genres, through: :movie_genres

  validates :rating,
    numericality: { only_integer: true, in: 0..10 }
end
