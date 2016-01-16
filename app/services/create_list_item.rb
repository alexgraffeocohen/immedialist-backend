class CreateListItem
  include Immedialist::ItemTypeConversion

  def self.call(list_item)
    new(list_item).call
  end

  def initialize(list_item)
    @list_item = list_item
  end

  def call
    return @list_item if list_item_invalid?

    AttachSearchToListItem.call(list_item)
    AttachQueryResultsToSearch.call(list_item.search)
    list_item.save!
  end

  private

  attr_reader :list_item

  def list_item_invalid?
    if !requested_item_attached?
      @list_item.errors.add(:item, "Must provide a valid item")
    end
  end

  def requested_item_attached?
    # The class check is not necessarily ideal. It couples this class to
    # how I decided to design creating ListItems from client side, with
    # a RequstedItem attached. At least now that is explicit.
    list_item.item && list_item.item.is_a?(RequestedItem)
  end
end
