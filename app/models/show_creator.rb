class ShowCreator < ActiveRecord::Base
  belongs_to :show
  belongs_to :creator

  validates_presence_of :creator, scope: :show
end
