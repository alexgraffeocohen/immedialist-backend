class ListItem < ActiveRecord::Base
  include Immedialist::ItemTypeConversion

  belongs_to :user
  belongs_to :item, polymorphic: true
  has_one :search, dependent: :destroy

  def to_item_type
    ItemType(item_type)
  end
end
