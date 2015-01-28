require 'rails_helper'

describe Query::Song do
  let(:song_query_with_real_name)  { Query::Song.new(name: real_name) }
  let(:song_query_with_fake_name)  { Query::Song.new(name: fake_name) }
  let(:song_query_with_real_id)    { Query::Song.new(external_id: real_id) }
  let(:song_query_with_fake_id)    { Query::Song.new(external_id: fake_id) }
  let(:real_name)                  { "Fake Empire" }
  let(:fake_name)                  { "The Greatest Song in The World: This is a Tribute" }
  let(:real_id)                    { "6aUAF8JOd8zEl41B6I18xL" }
  let(:fake_id)                    { "ithinkicanithinkicanithinkican" }

  describe '#call' do
    context 'with a name' do
      it 'returns an array of song results if there is a match' do
        VCR.use_cassette('real_name_song_query') do
          result = song_query_with_real_name.call

          expect(result).to be_an Array
          expect(result.first.name).to eq(real_name)
        end
      end

      it 'returns an empty array if there is no match' do
        VCR.use_cassette('fake_name_song_query') do
          result = song_query_with_fake_name.call

          expect(result).to be_an Array
          expect(result).to be_empty
        end
      end
    end

    context 'with an external id' do
      it 'returns a detailed song record if external id is recognized' do
        VCR.use_cassette('real_id_song_query') do
          result = song_query_with_real_id.call

          expect(result.name).to eq(real_name)
        end
      end

      it 'returns an error object if external id is not recognized' do
        VCR.use_cassette('fake_id_song_query') do
          expect { song_query_with_fake_id.call }.to raise_exception(RestClient::BadRequest)
        end
      end
    end
  end
end
