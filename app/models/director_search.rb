class DirectorSearch < ActiveRecord::Base
  belongs_to :creator
  belongs_to :search, class_name: Search::Director
end
