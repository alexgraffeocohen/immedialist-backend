class Category < ActiveRecord::Base
  has_many :movies
  has_many :songs
end
