require 'rails_helper'

RSpec.describe ListItem, :type => :model do
  let(:list_item) { FactoryGirl.build(:list_item) }

  it 'will receive the name of the item it is attached to' do
    item = FactoryGirl.create(:movie, name: 'Interstellar')
    list_item.item = item
    list_item.save

    expect(list_item.name).to eq(item.name)
  end
end
