class ShowActor < ActiveRecord::Base
  belongs_to :show
  belongs_to :actor, class_name: Person, foreign_key: :actor_id
end
