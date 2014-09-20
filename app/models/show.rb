class Show < ActiveRecord::Base
  has_many :directors, through: :show_directors
  has_many :show_directors
  has_many :actors, through: :show_actors
  has_many :show_actors
  has_many :genres, through: :show_genres
  has_many :show_genres
  belongs_to :category

  before_save :define_category

  private

  def define_category
    self.category = Category.find_or_create_by(name: "Television")
  end
end
