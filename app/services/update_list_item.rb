class UpdateListItem
  def self.call(list_item, attributes)
    new(list_item, attributes).call
  end

  def initialize(list_item, attributes)
    @list_item = list_item
    @attributes = attributes
  end

  def call
    list_item.update_attributes(attributes)
  end

  private

  attr_reader :list_item, :attributes
end
