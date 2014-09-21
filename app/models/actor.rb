class Actor < ActiveRecord::Base
  has_many :movies, through: :movie_actors
  has_many :movie_actors
  has_many :shows, through: :show_actors
  has_many :show_actors
  has_many :categories, through: :actor_categories
  has_many :actor_categories

  before_save :define_categories

  private

  def define_categories
    self.categories << Category.find_or_create_by(name: "Person")
    if self.movies
      self.categories << Category.find_or_create_by(name: "Movie")
    end
    if self.shows
      self.categories << Category.find_or_create_by(name: "Television")
    end
  end
end
