class Category < ActiveRecord::Base
  has_many :movies
  has_many :songs
  has_many :shows
  has_many :books
  has_many :creators, through: :creator_categories
  has_many :creator_categories
end
