class Genre < ActiveRecord::Base
  has_many :movies, through: :movie_genres
  has_many :movie_genres
  has_many :shows, through: :show_genres
  has_many :show_genres
  has_many :artists, through: :artist_genres
  has_many :artist_genres
end
