class Query < ActiveRecord::Base
  belongs_to :list_item

  validates_presence_of :list_item
end
