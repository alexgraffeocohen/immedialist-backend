class MovieActor < ActiveRecord::Base
  belongs_to :movie
  belongs_to :actor, class_name: Person, foreign_key: :actor_id
end
