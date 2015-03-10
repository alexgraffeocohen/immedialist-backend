class BookSearch < ActiveRecord::Base
  belongs_to :book
  belongs_to :search, class_name: Search::Book
end
