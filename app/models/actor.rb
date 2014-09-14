class Actor < ActiveRecord::Base
  has_many :movies, through: :actor_movies
  has_many :actor_movies
  has_many :shows, through: :show_actors
  has_many :show_actors
end
