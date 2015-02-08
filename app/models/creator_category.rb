class CreatorCategory < ActiveRecord::Base
  belongs_to :creator
  belongs_to :category
end
