require 'rails_helper'

RSpec.describe SaveResultsFromQuery, type: :service do
  let(:item_type) { Immedialist::ItemType::Movie.new }
  let(:test_query) { TestQuery::Movie.new }
  let(:saved_objects) { SaveResultsFromQuery.call(query_results, item_type) }

  before(:each) do
    saved_objects
  end

  context 'when query has results' do
    let(:query_results) { test_query.call_with_real_name }
    let(:real_movie)    { create(:real_movie) }

    it 'stores query results as objects in database' do
      the_matrix = Movie.find_by(name: real_movie.name)

      expect(the_matrix).to_not be_nil
    end

    it 'returns the objects it creates' do
      expect(saved_objects).to be_an(Array)
      expect(saved_objects.map(&:class).uniq).to eq([Movie])
    end
  end

  context 'when query does not have results' do
    let(:query_results) { test_query.call_with_fake_name }

    it 'returns an empty array' do
      expect(saved_objects).to be_an(Array)
      expect(saved_objects).to be_empty
    end
  end
end
