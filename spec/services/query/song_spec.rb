require 'rails_helper'

describe Query::Song do
  let(:test_query) { TestQuery::Song.new }
  let(:real_song) { build(:real_song) }
  let(:fake_song) { build(:fake_song) }

  describe '#call' do
    context 'with a name' do
      it 'returns an array of song results if there is a match' do
        result = test_query.call_with_real_name

        expect(result).to be_an Array
        expect(result.first.name).to eq(real_song.name)
      end

      it 'returns an empty array if there is no match' do
        result = test_query.call_with_fake_name

        expect(result).to be_an Array
        expect(result).to be_empty
      end
    end

    context 'with an external id' do
      it 'returns a detailed song record if external id is recognized' do
        result = test_query.call_with_real_id
        expect(result.name).to eq(real_song.name)
      end

      it 'returns an error object if external id is not recognized' do
        expect { test_query.call_with_fake_id }.to raise_exception(RestClient::BadRequest)
      end
    end
  end
end
