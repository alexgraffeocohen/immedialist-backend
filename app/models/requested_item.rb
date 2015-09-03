class RequestedItem < ActiveRecord::Base
  include Immedialist::ItemTypeConversion

  def to_item_type
    ItemType(requested_type)
  end
end
