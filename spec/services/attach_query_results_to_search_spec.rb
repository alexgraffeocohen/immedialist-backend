require 'rails_helper'

RSpec.describe AttachQueryResultsToSearch, type: :service do
  let(:search) { Search::Movie.create(list_item: list_item) }

  context 'given any search' do
    let(:list_item) { build(:list_item, name: "Generic Query") }

    it 'saves the search' do
      VCR.use_cassette('generic_list_item_query') do
        AttachQueryResultsToSearch.call(search)
      end

      expect(search).to be_persisted
    end
  end

  context 'given a search with results' do
    let(:list_item) { build(:list_item, name: "The Matrix") }

    it 'attaches query results to search as new item objects' do
      VCR.use_cassette('real_name_movie_query') do
        AttachQueryResultsToSearch.call(search)
      end

      expect(search.results).to_not be_empty
      expect(search.results.map(&:class).uniq).to eq([Movie])
    end
  end

  context 'given a search without results' do
    let(:list_item) { build(:list_item, name: "Absolutely No Results") }

    it 'saves query results as empty collection' do
      VCR.use_cassette('no_results_query') do
        AttachQueryResultsToSearch.call(search)
      end

      expect(search.results).to be_empty
    end
  end
end
