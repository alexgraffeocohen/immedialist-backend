require 'rails_helper'

RSpec.describe SaveResultsFromQuery, type: :service do
  let(:item_type) { Immedialist::ItemType::Movie.new }
  let(:test_query) { TestQuery::Movie.new }
  let(:saved_objects) {
    VCR.use_cassette(fixture) do
      SaveResultsFromQuery.call(query, item_type)
    end
  }

  before(:each) do
    saved_objects
  end

  context 'when query has results' do
    let(:query) { Query::Movie.new(name: real_movie.name) }
    let(:real_movie) { create(:real_movie) }
    let(:fixture) { test_query.real_name_fixture }

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
    let(:query) { Query::Movie.new(name: fake_movie.name) }
    let(:fake_movie) { create(:fake_movie) }
    let(:fixture) { test_query.fake_name_fixture }

    it 'returns an empty array' do
      expect(saved_objects).to be_an(Array)
      expect(saved_objects).to be_empty
    end
  end
end
