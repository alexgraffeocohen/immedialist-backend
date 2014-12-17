require 'rails_helper'

describe SongSearch do
  let(:song_search_with_real_title) { SongSearch.new(title: real_title) }
  let(:song_search_with_fake_title) { SongSearch.new(title: fake_title) }
  let(:song_search_with_real_id)    { SongSearch.new(external_id: real_id) }
  let(:song_search_with_fake_id)    { SongSearch.new(external_id: fake_id) }
  let(:real_title)                  { "Fake Empire" }
  let(:fake_title)                  { "The Greatest Song in The World: This is a Tribute" }
  let(:real_id)                     { "6aUAF8JOd8zEl41B6I18xL" }
  let(:fake_id)                     { "ithinkicanithinkicanithinkican" }

  describe '#search' do
    context 'with a title' do
      it 'returns an array of song results if there is a match' do
        VCR.use_cassette('real_title_song_search') do
          result = song_search_with_real_title.search

          expect(result).to be_an Array
          expect(result.first.name).to eq(real_title)
        end
      end

      it 'returns an empty array if there is no match' do
        VCR.use_cassette('fake_title_song_search') do
          result = song_search_with_fake_title.search

          expect(result).to be_an Array
          expect(result).to be_empty
        end
      end
    end

    context 'with an external id' do
      it 'returns a detailed song record if external id is recognized' do
        VCR.use_cassette('real_id_song_search') do
          result = song_search_with_real_id.search

          expect(result.name).to eq(real_title)
        end
      end

      it 'returns an error object if external id is not recognized' do
        VCR.use_cassette('fake_id_song_search') do
          expect { song_search_with_fake_id.search }.to raise_exception(RestClient::BadRequest)
        end
      end
    end
  end
end
