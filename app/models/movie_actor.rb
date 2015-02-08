class MovieActor < ActiveRecord::Base
  belongs_to :movie
  belongs_to :creator
end
