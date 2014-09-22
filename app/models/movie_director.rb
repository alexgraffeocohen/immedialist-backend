class MovieDirector < ActiveRecord::Base
  belongs_to :movie
  belongs_to :director, class_name: Person, foreign_key: :director_id
end
