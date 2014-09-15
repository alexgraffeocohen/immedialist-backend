class Movie < ActiveRecord::Base
  has_many :genres, through: :movie_genres
  has_many :movie_genres
  has_many :actors, through: :movie_actors
  has_many :movie_actors
  has_many :directors, through: :movie_directors
  has_many :movie_directors

  def category
    :film
  end
end
