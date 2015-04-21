class AuthorSearch < ActiveRecord::Base
  belongs_to :creator
  belongs_to :search, class_name: Search::Author
end
