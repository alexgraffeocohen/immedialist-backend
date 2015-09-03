require 'rails_helper'

RSpec.describe CreateListItem, type: :service do
  context 'given any list item' do
    let(:list_item) { FactoryGirl.build(:list_item,
                                        name: "Generic Query",
                                        item: item) }
    let(:item) { FactoryGirl.build(:requested_item, requested_type: "Movie") }

    it 'returns a saved list item' do
      VCR.use_cassette('generic_list_item_query') do
        CreateListItem.call(list_item)

        expect(list_item).to be_persisted
      end
    end
  end

  context 'when the list item name yields query results' do
    let(:list_item) { FactoryGirl.build(:list_item,
                                        name: "The Matrix",
                                        item: item) }
    let(:item) { FactoryGirl.build(:requested_item, requested_type: "Movie") }

    it 'attaches relevant results to the list item' do
      VCR.use_cassette('real_name_movie_query') do
        CreateListItem.call(list_item)
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
