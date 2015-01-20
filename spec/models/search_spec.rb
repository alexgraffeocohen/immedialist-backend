require 'rails_helper'

RSpec.describe Search, :type => :model do
  let(:film_category) { create(:film_category) }
  let(:list_item) { build(:list_item, category: film_category) }

  it 'inherits name from it\'s list item' do
    search = Search.new(list_item: list_item)
    search.save

    expect(search.name).to eq(list_item.name)
  end
end
