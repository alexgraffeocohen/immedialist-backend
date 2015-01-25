class Category < ActiveRecord::Base
  has_many :movies
  has_many :songs
  has_many :shows
  has_many :books
  has_many :people, through: :person_categories
  has_many :person_categories
end
