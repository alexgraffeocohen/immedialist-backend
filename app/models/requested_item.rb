class RequestedItem < ActiveRecord::Base
  include Immedialist::ItemTypeConversion

  has_one :list_item, as: :item

  def to_item_type
    ItemType(requested_type)
  end
end
