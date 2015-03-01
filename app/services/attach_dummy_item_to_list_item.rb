class AttachDummyItemToListItem
  def self.call(list_item, item_type)
    new(list_item, item_type).call
  end

  def initialize(list_item, item_type)
    @list_item = list_item
    @item_type = item_type
  end

  def call
    dummy_item = item_class.new(name: list_item.name)
    list_item.item = dummy_item
    dummy_item.save!
  end

  private

  attr_accessor :list_item
  attr_reader :item_type

  def item_class
    item_type.associated_class
  end
end
