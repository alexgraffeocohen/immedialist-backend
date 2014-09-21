class Actor < ActiveRecord::Base
  has_many :movies, through: :movie_actors
  has_many :movie_actors
  has_many :shows, through: :show_actors
  has_many :show_actors
  has_many :categories, through: :actor_categories
  has_many :actor_categories

  after_create :assign_to_person_category
  after_save :assign_associated_categories

  private

  def assign_associated_categories
    CategoryManager.new(self).assign_categories
  end

  def assign_to_person_category
    self.categories << Category.find_or_create_by(name: "Person")
  end
end
