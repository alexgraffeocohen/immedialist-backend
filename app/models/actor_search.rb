class ActorSearch < ActiveRecord::Base
  belongs_to :creator
  belongs_to :search, class_name: Search::Actor
end
