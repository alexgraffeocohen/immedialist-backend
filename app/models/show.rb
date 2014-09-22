class Show < ActiveRecord::Base
  has_many :directors, through: :show_directors, class_name: Person, foreign_key: :actor_id
  has_many :show_directors
  has_many :actors, through: :show_actors, class_name: Person, foreign_key: :actor_id
  has_many :show_actors
  has_many :genres, through: :show_genres
  has_many :show_genres
  belongs_to :category

  after_create :assign_to_television_category

  private

  def assign_to_television_category
    self.category = Category.find_or_create_by(name: "Television")
  end
end
