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
    CreateListItemValidator.new(list_item).invalid?
  end
end
