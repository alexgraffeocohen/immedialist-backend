class AttachSearchToListItem
  def self.call(list_item, item_type)
    list_item.search = Search.const_get(item_type.name).new
  end
end
