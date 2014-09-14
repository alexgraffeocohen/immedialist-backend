class Director < ActiveRecord::Base
  has_many :movies, through: :director_movies
  has_many :director_movies
  has_many :shows, through: :show_directors
  has_many :show_directors
end
