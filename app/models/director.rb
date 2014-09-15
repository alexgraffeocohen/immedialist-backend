class Director < ActiveRecord::Base
  has_many :movies, through: :movie_directors
  has_many :movie_directors
  has_many :shows, through: :show_directors
  has_many :show_directors
end
