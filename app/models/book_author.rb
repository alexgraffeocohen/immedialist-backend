class BookAuthor < ActiveRecord::Base
  belongs_to :book
  belongs_to :creator
end
