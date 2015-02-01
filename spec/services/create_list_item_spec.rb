require 'rails_helper'

RSpec.describe CreateListItem, type: :service do
  let(:list_item)           { build(:list_item, name: "The Matrix") }
  let(:requested_item_type) { "Movie" }

  before(:each) do
    VCR.use_cassette('real_name_movie_query') do
      CreateListItem.call(list_item, requested_item_type)
    end
  end

  it 'saves the list item passed to it' do
    expect(list_item).to be_persisted
  end

  it 'attaches search results to list item' do
    expect(list_item.search.results).to_not be_empty
  end
end
