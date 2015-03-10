class CreateListItem
  include Immedialist::ItemTypeConversion

  def self.call(list_item_params)
    new(list_item_params).call
  end

  def initialize(list_item_params)
    @item_type = list_item_params.fetch(:item_type)
    @name = list_item_params.fetch(:name)
  end

  def call
    ListItem.new(name: name, item_type: item_type) do |list_item|
      AttachSearchToListItem.call(list_item)
      AttachQueryResultsToSearch.call(list_item.search)
    end
  end

  private

  attr_reader :item_type, :name
end
