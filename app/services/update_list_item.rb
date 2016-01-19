class UpdateListItem
  def self.call(list_item, attributes)
    new(list_item, attributes).call
  end

  def initialize(list_item, attributes)
    @list_item = list_item
    @attributes = attributes
  end

  def call
    update_item_class.call(selected_item)
    list_item.update_attributes!(attributes)
  end

  private

  attr_reader :list_item, :attributes

  def selected_item
    selected_item_class.find(attributes[:item_id])
  end

  def selected_item_class
    attributes[:item_type].constantize
  end

  def update_item_class
    UpdateItem.const_get(selected_item_class.name, false)
  end
end
