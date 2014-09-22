class Movie < ActiveRecord::Base
  has_many :genres, through: :movie_genres
  has_many :movie_genres
  has_many :actors, through: :movie_actors, class_name: Person, foreign_key: :actor_id
  has_many :movie_actors
  has_many :directors, through: :movie_directors, class_name: Person, foreign_key: :director_id
  has_many :movie_directors
  belongs_to :category

  after_create :assign_to_film_category

  private

  def assign_to_film_category
    self.category = Category.find_or_create_by(name: "Film")
  end
end
