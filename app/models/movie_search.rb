class MovieSearch < ActiveRecord::Base
  belongs_to :movie
  belongs_to :search, class_name: Search::Movie
end
