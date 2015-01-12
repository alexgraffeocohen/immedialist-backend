class Book < ActiveRecord::Base
  has_many :book_authors
  has_many :authors, through: :book_authors, class_name: Person, foreign_key: :author_id
  has_many :book_genres
  has_many :genres, through: :book_genres
  belongs_to :category
  has_many :list_items, as: :item

  before_create :assign_to_book_category

  private

  def assign_to_book_category
    self.category = Category.find_or_create_by(name: "Book")
  end
end
