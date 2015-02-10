require 'rails_helper'

describe Query::Album do
  let(:test_query) { TestQuery::Album.new }
  let(:real_album) { build(:real_album) }
  let(:fake_album) { build(:fake_album) }

  describe '#call' do
    context 'with a name' do
      it 'returns an array of album results if there is a match' do
        result = test_query.call_with_real_name

        expect(result).to be_an Array
        expect(result.first.name).to eq(real_album.name)
        expect { result.first.release_date }.to raise_exception(VCR::Errors::UnhandledHTTPRequestError)
        expect(result.first.id).to_not be_nil
      end

      it 'returns an empty array if there is no match' do
        result = test_query.call_with_fake_name

        expect(result).to be_an Array
        expect(result).to be_empty
      end
    end

    context 'with an external id' do
      it 'returns a detailed album record if external id is recognized' do
        result = test_query.call_with_real_id

        expect(result.name).to eq(real_album.name)
        expect(result.release_date).to eq(real_album.release_date.to_s)
        expect(result.genres).to be_an Array
      end

      it 'returns an error object if external id is not recognized' do
        expect { test_query.call_with_fake_id }.to raise_exception(RestClient::BadRequest)
      end
    end
  end
end
