class Actor < ActiveRecord::Base
  has_many :movies, through: :movie_actors
  has_many :movie_actors
  has_many :shows, through: :show_actors
  has_many :show_actors
end
