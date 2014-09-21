class Author < ActiveRecord::Base
  has_many :book_authors
  has_many :books, through: :book_authors
  has_many :categories, through: :author_categories
  has_many :author_categories

  include PeopleCallbacks
end
