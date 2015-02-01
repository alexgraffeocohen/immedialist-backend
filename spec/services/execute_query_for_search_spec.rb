require 'rails_helper'

RSpec.describe ExecuteQueryForSearch, type: :service do
  let(:list_item) { ListItem.new(name: "The Matrix") }
  let(:search)    { Search::Movie.create(list_item: list_item) }
  let(:item_type) { Immedialist::ItemType::Movie.new }

  before(:each) do
    VCR.use_cassette('real_name_movie_query') do
      ExecuteQueryForSearch.call(search, item_type)
    end
  end

  it 'attaches query results to search as new item objects' do
    expect(search.results).to_not be_empty
    expect(search.results.map(&:class).uniq).to eq([Movie])
  end
end
