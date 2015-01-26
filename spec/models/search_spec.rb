require 'rails_helper'

RSpec.describe Search, :type => :model do
  let(:list_item) { build(:list_item) }

  it 'inherits name from it\'s list item on save' do
    search = build(:search, list_item: list_item)
    search.save

    expect(search.name).to eq(list_item.name)
  end
end
