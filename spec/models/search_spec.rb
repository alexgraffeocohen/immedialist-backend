require 'rails_helper'

RSpec.describe Search, :type => :model do
  let(:list_item) { create(:list_item) }

  it { should belong_to(:list_item) }

  it_behaves_like "it can be converted to an item type", Search::Movie.new

  it 'inherits name from it\'s list item on save' do
    search = build(:search, list_item: list_item)
    search.save

    expect(search.name).to eq(list_item.name)
  end
end
