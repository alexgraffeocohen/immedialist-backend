class CreateListItemValidator
  def initialize(list_item)
    @list_item = list_item
  end

  def invalid?
    !valid?
  end

  def valid?
    list_item.valid? && requested_item_attached?
  end

  private

  attr_reader :list_item

  def requested_item_attached?
    if requested_item_not_attached?
      list_item.errors.add(:item, "Must be a RequestedItem")
      false
    else
      true
    end
  end

  def requested_item_not_attached?
    # The class check is not necessarily ideal. It couples CreateListItem
    # to how I decided to design creating ListItems from client side, with
    # a RequstedItem attached. At least now that is explicit.
    !list_item.item || !list_item.item.is_a?(RequestedItem)
  end
end
