require 'rails_helper'

RSpec.describe ListItem, :type => :model do
  let(:list_item) { FactoryGirl.create(:list_item) }

  it 'will receive the title of the item it is attached to' do
    tv_show = FactoryGirl.create(:show, name: 'Boardwalk Empire')
    list_item.item = tv_show
    list_item.save

    expect(list_item.item).to eq(tv_show)
    expect(list_item.name).to eq('Boardwalk Empire')
  end
end
