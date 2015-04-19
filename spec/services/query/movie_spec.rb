require 'rails_helper'

describe Query::Movie do
  let(:test_query) { TestQuery::Movie.new }
  let(:real_movie) { build(:real_movie) }
  let(:fake_movie) { build(:fake_movie) }

  describe '#call' do
    context 'with a name' do
      it 'returns an array of movie results if there is a match' do
        result = test_query.call_with_real_name

        expect(result).to be_an Array
        expect(result.first.title).to eq(real_movie.name)
        expect(result.first.release_date).to include(real_movie.release_date.to_s)
        expect(result.first.id).to_not be_nil
      end

      it 'returns an empty array if there is no match' do
        result = test_query.call_with_fake_name

        expect(result).to be_an Array
        expect(result).to be_empty
      end
    end

    context 'with an external id' do
      it 'returns a detailed movie record if external id is recognized' do
        result = test_query.call_with_real_id

        expect(result['title']).to eq(real_movie.name)
        expect(result['release_date']).to include(real_movie.release_date.to_s)
        expect(result['imdb_id']).to_not be_nil
        expect(result['genres']).to be_an Array
      end

      it 'returns an error object if external id is not recognized' do
        result = test_query.call_with_fake_id

        expect(result['status_message']).to include("Invalid id")
      end
    end
  end
end
