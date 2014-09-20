class Category < ActiveRecord::Base
  has_many :movies
  has_many :songs
  has_many :shows
  has_many :books
  has_many :actors, through: :actor_categories
  has_many :actor_categories
end
