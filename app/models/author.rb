class Author < ActiveRecord::Base
  has_many :book_authors
  has_many :books, through: :book_authors
  has_many :categories, through: :author_categories
  has_many :author_categories

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
