class ShowDirector < ActiveRecord::Base
  belongs_to :show
  belongs_to :director
end
