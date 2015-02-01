require 'rails_helper'

RSpec.describe ExecuteQueryForSearch, type: :service do
  it 'attaches query results to search as new item objects' do
    VCR.use_cassette('real_name_movie_query') do
      list_item = ListItem.new(name: "The Matrix")
      search = Search::Movie.new(list_item: list_item)
      search.save

      item_type = Immedialist::ItemType::Movie.new

      ExecuteQueryForSearch.call(search, item_type)

      expect(search.results).to_not be_empty
      expect(search.results.map(&:class).uniq).to eq([Movie])
    end
  end
end
