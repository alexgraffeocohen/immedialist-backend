class Genre < ActiveRecord::Base
  has_many :movies, through: :genre_movies
  has_many :genre_movies
end
