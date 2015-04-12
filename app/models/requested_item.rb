class RequestedItem < ActiveRecord::Base
  include Immedialist::ItemTypeConversion

  def to_item_type
    ItemType(media_name)
  end
end
