require 'rails_helper'

RSpec.describe AttachSearchToListItem, type: :service do
  it 'creates a search for a list_item based on item_type' do
    list_item = build(:list_item, item: FactoryGirl.build(:movie))

    AttachSearchToListItem.call(list_item)

    expect(list_item.search).to be_a(Search::Movie)
    expect(list_item.search).to be_persisted
  end
end
