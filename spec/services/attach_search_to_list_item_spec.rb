require 'rails_helper'

RSpec.describe AttachSearchToListItem, type: :service do
  it 'creates a search for a list_item based on item_type' do
    list_item = build(:list_item)
    item_type = Immedialist::ItemType::Movie.new

    AttachSearchToListItem.call(list_item, item_type)

    expect(list_item.search).to be_a(Search::Movie)
    expect(list_item.search).to be_persisted
  end
end
