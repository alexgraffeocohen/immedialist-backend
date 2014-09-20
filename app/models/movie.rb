class Movie < ActiveRecord::Base
  has_many :genres, through: :movie_genres
  has_many :movie_genres
  has_many :actors, through: :movie_actors
  has_many :movie_actors
  has_many :directors, through: :movie_directors
  has_many :movie_directors
  belongs_to :category

  before_save :define_category

  private

  def define_category
    self.category = Category.find_or_create_by(name: "Film")
  end
end
