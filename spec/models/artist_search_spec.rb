require 'rails_helper'

describe ArtistSearch do
  let(:artist_search_with_real_name)   { ArtistSearch.new(name: real_name) }
  let(:artist_search_with_common_name) { ArtistSearch.new(name: common_name) }
  let(:artist_search_with_fake_name)   { ArtistSearch.new(name: fake_name) }
  let(:artist_search_with_real_id)     { ArtistSearch.new(external_id: real_id) }
  let(:artist_search_with_fake_id)     { ArtistSearch.new(external_id: fake_id) }
  let(:real_name)                     { "The National" }
  let(:fake_name)                     { "Why Did I Even Start Writing Music I'm a Failure" }
  let(:real_id)                       { "2cCUtGK9sDU2EoElnk0GNB" }
  let(:fake_id)                       { "ithinkicanithinkicanithinkican" }

  describe '#search' do
    context 'with an exact name' do
      it 'returns an array with a single artist result' do
        VCR.use_cassette('exact_name_artist_search') do
          result = artist_search_with_real_name.search

          expect(result).to be_an Array
          expect(result.first.name).to eq(real_name)
          expect(result.first.genres).to_not be_empty
        end
      end
    end

    context 'with a fake name' do
      it 'returns an empty array' do
        VCR.use_cassette('fake_name_artist_search') do
          result = artist_search_with_fake_name.search

          expect(result).to be_an Array
          expect(result).to be_empty
        end
      end
    end

    context 'with an external id' do
      it 'returns a single artist record if external id is recognized' do
        VCR.use_cassette('real_id_artist_search') do
          result = artist_search_with_real_id.search

          expect(result.name).to eq(real_name)
          expect(result.genres).to_not be_empty
        end
      end

      it 'returns an error object if external id is not recognized' do
        VCR.use_cassette('fake_id_artist_search') do
          expect { artist_search_with_fake_id.search }.to raise_exception(RestClient::BadRequest)
        end
      end
    end
  end
end
