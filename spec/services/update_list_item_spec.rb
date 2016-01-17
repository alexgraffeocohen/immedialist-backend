require 'rails_helper'

RSpec.describe UpdateListItem, type: :service do
  context 'given any list item' do
    let(:list_item) { FactoryGirl.create(:list_item,
                                         name: "An Old Name",
                                         item: item) }
    let(:item) { FactoryGirl.create(:movie) }

    it 'updates the list item' do
      UpdateListItem.call(
        list_item,
        { name: "A New Name" }
      )

      expect(list_item.name).to eq("A New Name")
    end
  end
end
