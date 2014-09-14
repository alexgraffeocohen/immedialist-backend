class Show < ActiveRecord::Base
  has_many :directors, through: :show_directors
  has_many :show_directors
  has_many :actors, through: :show_actors
  has_many :show_actors
  has_many :genres, through: :show_genres
  has_many :show_genres
end
