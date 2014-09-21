class DirectorCategory < ActiveRecord::Base
  belongs_to :director
  belongs_to :category
end
