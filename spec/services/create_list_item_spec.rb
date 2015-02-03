require 'rails_helper'

RSpec.describe CreateListItem, type: :service do
  let(:search_results) { list_item.search.results }

  context 'given any list item' do
    let(:list_item)           { build(:list_item, name: "Generic Query") }
    let(:requested_item_type) { "Movie" }

    before(:each) do
      VCR.use_cassette('generic_list_item_query') do
        CreateListItem.call(list_item, requested_item_type)
      end
    end

    it 'saves the list item passed to it' do
      expect(list_item).to be_persisted
    end
  end

  context 'when the list item name yields query results' do
    let(:list_item)           { build(:list_item, name: "The Matrix") }
    let(:requested_item_type) { "Movie" }

    before(:each) do
      VCR.use_cassette('real_name_movie_query') do
        CreateListItem.call(list_item, requested_item_type)
      end
    end

    it 'attaches relevant results to the list item' do
      expect(search_results).to_not be_empty
      expect(search_results.map(&:class).uniq).to eq([Movie])

      relevant_movie = search_results.select { |m| m.name == "The Matrix" }

      expect(relevant_movie).to_not be_nil
    end
  end
end
