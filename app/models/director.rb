class Director < ActiveRecord::Base
  has_many :movies, through: :movie_directors
  has_many :movie_directors
  has_many :shows, through: :show_directors
  has_many :show_directors
  has_many :categories, through: :director_categories
  has_many :director_categories

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
