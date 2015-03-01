require 'rails_helper'

RSpec.describe CreateListItem, type: :service do
  context 'given any list item' do
    let(:list_item_params) {{ name: "Generic Query", type: "Movie" }}

    it 'returns a saved list item' do
      VCR.use_cassette('generic_list_item_query') do
        list_item = CreateListItem.call(list_item_params)

        expect(list_item).to be_persisted
      end
    end
  end

  context 'when the list item name yields query results' do
    let(:list_item_params) {{ name: "The Matrix", type: "Movie" }}

    it 'attaches relevant results to the list item' do
      VCR.use_cassette('real_name_movie_query') do
        list_item = CreateListItem.call(list_item_params)
        search_results = list_item.search.results

        expect(search_results).to_not be_empty
        expect(search_results.map(&:class).uniq).to eq([Movie])

        relevant_movie = search_results.select do |m|
          m.name == "The Matrix"
        end

        expect(relevant_movie).to_not be_nil
      end
    end
  end
end
