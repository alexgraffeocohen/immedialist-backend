class ShowDirector < ActiveRecord::Base
  belongs_to :show
  belongs_to :director, class_name: Person, foreign_key: :director_id
end
