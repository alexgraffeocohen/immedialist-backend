class CreateListItem
  include Immedialist::ItemTypeConversion

  def self.call(list_item)
    new(list_item).call
  end

  def initialize(list_item)
    @list_item = list_item
  end

  def call
    if requested_item_attached?
      AttachSearchToListItem.call(list_item)
      AttachQueryResultsToSearch.call(list_item.search)
      list_item.save!
    else
      @list_item.errors.add(:item, "Must provide a valid item")
    end
  end

  private

  attr_reader :list_item

  def requested_item_attached?
    list_item.item
  end
end
