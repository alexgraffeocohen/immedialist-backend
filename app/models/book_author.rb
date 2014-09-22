class BookAuthor < ActiveRecord::Base
  belongs_to :book
  belongs_to :author, class_name: Person, foreign_key: :author_id
end
