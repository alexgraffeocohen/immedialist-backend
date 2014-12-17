require 'rails_helper'

describe AlbumSearch do
  let(:album_search_with_real_title) { AlbumSearch.new(title: real_title) }
  let(:album_search_with_fake_title) { AlbumSearch.new(title: fake_title) }
  let(:album_search_with_real_id)    { AlbumSearch.new(external_id: real_id) }
  let(:album_search_with_fake_id)    { AlbumSearch.new(external_id: fake_id) }
  let(:real_title)                   { "Random Access Memories" }
  let(:fake_title)                   { "GKFJGBNDJKGKFJFBDHDBGKGJDBGKGJDBGKDHGB" }
  let(:release_date)                 { "2013-05-17" }
  let(:real_id)                      { "4m2880jivSbbyEGAKfITCa" }
  let(:fake_id)                      { "ithinkicanithinkicanithinkican" }

  describe '#search' do
    context 'with a title' do
      it 'returns an array of album results if there is a match' do
        VCR.use_cassette('real_title_album_search') do
          result = album_search_with_real_title.search

          expect(result).to be_an Array
          expect(result.first.name).to eq(real_title)
          expect(result.first.release_date).to eq(release_date)
        end
      end

      it 'returns an empty array if there is no match' do
        VCR.use_cassette('fake_title_album_search') do
          result = album_search_with_fake_title.search

          expect(result).to be_an Array
          expect(result).to be_empty
        end
      end
    end

    context 'with an external id' do
      it 'returns a detailed album record if external id is recognized' do
        VCR.use_cassette('real_id_album_search') do
          result = album_search_with_real_id.search

          expect(result.name).to eq(real_title)
          expect(result.release_date).to eq(release_date)
          expect(result.genres).to be_an Array
        end
      end

      it 'returns an error object if external id is not recognized' do
        VCR.use_cassette('fake_id_album_search') do
          expect { album_search_with_fake_id.search }.to raise_exception(RestClient::BadRequest)
        end
      end
    end
  end
end
