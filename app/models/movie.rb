class Movie < ActiveRecord::Base
  has_many :genres, through: :movie_genres
  has_many :movie_genres
  has_many :actors, through: :movie_actors, source: :creator
  has_many :movie_actors
  has_many :directors, through: :movie_directors, source: :creator
  has_many :movie_directors
  has_many :list_items, as: :item
end
