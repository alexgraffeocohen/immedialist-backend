require 'rails_helper'

RSpec.describe AttachDummyItemToListItem, type: :service do
  let(:list_item) { build(:list_item, name: "The Matrix") }
  let(:item_type) { Immedialist::ItemType::Movie.new }

  before(:each) do
    AttachDummyItemToListItem.call(list_item, item_type)
  end

  it 'attaches an item to a list item based on the item type supplied' do
    expect(list_item.item).to_not be_nil
    expect(list_item.item_type).to eq("Movie")
  end

  it 'saves the item that it attaches' do
    expect(list_item.item).to be_persisted
  end
end
