class Book < ActiveRecord::Base
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :book_genres
  has_many :genres, through: :book_genres
  belongs_to :category

  before_save :define_category

  private

  def define_category
    self.category = Category.find_or_create_by(name: "Book")
  end
end
