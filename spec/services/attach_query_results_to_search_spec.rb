require 'rails_helper'

RSpec.describe AttachQueryResultsToSearch, type: :service do
  let(:list_item) { ListItem.new(name: "The Matrix") }
  let(:search)    { Search::Movie.create(list_item: list_item) }
  let(:item_type) { Immedialist::ItemType::Movie.new }

  before(:each) do
    VCR.use_cassette('real_name_movie_query') do
      AttachQueryResultsToSearch.call(search, item_type)
    end
  end

  it 'attaches query results to search as new item objects' do
    expect(search.results).to_not be_empty
    expect(search.results.map(&:class).uniq).to eq([Movie])
  end

  it 'saves the search' do
    expect(search).to be_persisted
  end
end
