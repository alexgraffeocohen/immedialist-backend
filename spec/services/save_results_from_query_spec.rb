require 'rails_helper'

RSpec.describe SaveResultsFromQuery, type: :service do
  let(:item_type) { Immedialist::ItemType::Movie.new }

  before(:each) do
    query_results
  end

  context 'when query has results' do
    let(:query) { Query::Movie.new(name: "The Matrix") }
    let(:query_results) do
      VCR.use_cassette('real_name_movie_query') do
        SaveResultsFromQuery.call(query, item_type)
      end
    end

    it 'stores query results as objects in database' do
      the_matrix = Movie.find_by(name: "The Matrix")

      expect(the_matrix).to_not be_nil
    end

    it 'returns the objects it creates' do
      expect(query_results).to be_an(Array)
      expect(query_results.map(&:class).uniq).to eq([Movie])
    end
  end

  context 'when query does not have results' do
    let(:query) { Query::Movie.new(name: "Generic Query") }
    let(:query_results) do
      VCR.use_cassette('generic_list_item_query') do
        SaveResultsFromQuery.call(query, item_type)
      end
    end

    it 'returns an empty array' do
      expect(query_results).to be_an(Array)
      expect(query_results).to be_empty
    end
  end
end
