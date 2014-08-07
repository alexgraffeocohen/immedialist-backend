class Movie < ActiveRecord::Base
  has_many :genres, through: :genre_movies
  has_many :genre_movies
  has_many :actors, through: :actor_movies
  has_many :actor_movies
  has_many :directors, through: :director_movies
  has_many :director_movies

  before_save :calculate_filmetric

  private

  def calculate_filmetric
    self.filmetric = self.critics_score - self.audience_score
  end
end
