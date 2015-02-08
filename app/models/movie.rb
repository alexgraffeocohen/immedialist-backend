class Movie < ActiveRecord::Base
  has_many :genres, through: :movie_genres
  has_many :movie_genres
  has_many :actors, through: :movie_actors, source: :creator
  has_many :movie_actors
  has_many :directors, through: :movie_directors, source: :creator
  has_many :movie_directors
  belongs_to :category
  has_many :list_items, as: :item

  before_create :assign_to_film_category

  private

  def assign_to_film_category
    self.category = Category.find_or_create_by(name: "Film")
  end
end
