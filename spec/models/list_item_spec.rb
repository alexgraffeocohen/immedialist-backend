require 'rails_helper'

RSpec.describe ListItem, :type => :model do
  let!(:film)     { FactoryGirl.create(:film_category) }
  let(:list_item) { FactoryGirl.build(:list_item, category: film) }

  it 'will receive the name of the item it is attached to' do
    item = FactoryGirl.create(:movie, name: 'Interstellar')
    list_item.item = item
    list_item.save

    expect(list_item.name).to eq(item.name)
  end

  it 'can only be assigned an item corresponding to its category' do
    list_item.item = build(:book)

    expect(list_item).to_not be_valid
  end
end
