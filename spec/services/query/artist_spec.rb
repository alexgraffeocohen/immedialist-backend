require 'rails_helper'

describe Query::Artist do
  let(:test_query)  { TestQuery::Artist.new }
  let(:real_artist) { build(:real_artist) }
  let(:fake_artist) { build(:fake_artist) }

  describe '#call' do
    context 'with an exact name' do
      it 'returns an array of artist results if there is a match' do
        result = test_query.call_with_real_name

        expect(result).to be_an Array
        expect(result.first.name).to eq(real_artist.name)
        expect(result.first.genres).to_not be_empty
      end
    end

    context 'with a fake name' do
      it 'returns an empty array if there is no match' do
        result = test_query.call_with_fake_name

        expect(result).to be_an Array
        expect(result).to be_empty
      end
    end

    context 'with an external id' do
      it 'returns a detailed artist record if external id is recognized' do
        result = test_query.call_with_real_id
        expect(result.name).to eq(real_artist.name)
        expect(result.genres).to_not be_empty
      end

      it 'returns an error object if external id is not recognized' do
        expect { test_query.call_with_fake_id }.to raise_exception(RestClient::BadRequest)
      end
    end
  end
end
