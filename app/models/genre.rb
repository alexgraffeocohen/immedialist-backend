class Genre < ActiveRecord::Base
  has_many :movies, through: :genre_movies
  has_many :genre_movies
  has_many :shows, through: :show_genres
  has_many :show_genres
end
