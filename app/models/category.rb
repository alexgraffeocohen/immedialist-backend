class Category < ActiveRecord::Base
  has_many :movies
  has_many :songs
  has_many :shows
end
