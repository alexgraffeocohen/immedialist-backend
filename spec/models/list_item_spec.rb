require 'rails_helper'

RSpec.describe ListItem, :type => :model do
  let(:list_item) { FactoryGirl.create(:list_item) }

  it 'can be attached to a media item' do
    tv_show = FactoryGirl.create(:show)
    list_item.item = tv_show
    list_item.save

    expect(list_item.item).to eq(tv_show)
    expect(list_item.item_type).to eq('Show')
  end
end
