class CreateListItem
  def self.call(list_item, requested_item_type)
    new(list_item, requested_item_type).call
  end

  def initialize(list_item, requested_item_type)
    @item_type = LookUpItemType.call(requested_item_type)
    @list_item = list_item
  end

  def call
    AttachSearchToListItem.call(list_item, item_type)
    AttachQueryResultsToSearch.call(list_item.search, item_type)
    list_item.save!
  end

  private

  attr_reader :item_type, :list_item
end
