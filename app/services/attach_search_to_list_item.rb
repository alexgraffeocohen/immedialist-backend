class AttachSearchToListItem
  def self.call(list_item, item_type)
    search = Search.const_get(item_type.name).new
    list_item.search = search
    search.save!
  end
end
