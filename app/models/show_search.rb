class ShowSearch < ActiveRecord::Base
  belongs_to :show
  belongs_to :search, class_name: Search::Show
end
