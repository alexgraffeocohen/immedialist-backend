require 'rails_helper'

RSpec.describe UpdateListItem, type: :service do
  context 'given a list item with a new item' do
    let(:list_item) { FactoryGirl.create(:list_item, :with_search) }
    let(:item) { FactoryGirl.create(:movie) }
    let(:attributes) {
      { item_type: "Movie", item_id: item.id }
    }

    it 'updates the item and attaches it to the ListItem' do
      expect(UpdateItem::Base).
        to receive(:call).
        with(item).
        and_return(item)

      UpdateListItem.call(list_item, attributes)

      expect(list_item.item).to eq(item)
    end
  end
end
