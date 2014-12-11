require 'rails_helper'

describe MovieSearch do
  let(:movie_search_with_real_title) { MovieSearch.new(title: real_title) }
  let(:movie_search_with_fake_title) { MovieSearch.new(title: fake_title) }
  let(:movie_search_with_real_id)    { MovieSearch.new(external_id: real_id) }
  let(:movie_search_with_fake_id)    { MovieSearch.new(external_id: fake_id) }
  let(:real_title)                   { "The Matrix" }
  let(:release_year)                 { "1999" }
  let(:fake_title)                   { "When You Bite The Fry, the Fry Bites Back" }
  let(:real_id)                      { 603 }
  let(:fake_id)                      { 90909090 }

  describe '#search' do
    context 'with a title' do
      it 'returns an array of movie results if there is a match' do
        VCR.use_cassette('real_title_movie_search') do
          result = movie_search_with_real_title.search

          expect(result).to be_an Array
          expect(result.first.title).to eq(real_title)
          expect(result.first.release_date).to include(release_year)
          expect(result.first.id).to_not be_nil
        end
      end

      it 'returns an empty array if there is no match' do
        VCR.use_cassette('fake_title_movie_search') do
          result = movie_search_with_fake_title.search

          expect(result).to be_an Array
          expect(result).to be_empty
        end
      end
    end

    context 'with an external id' do
      it 'returns a detailed movie record if external id is recognized' do
        VCR.use_cassette('real_id_movie_search') do
          result = movie_search_with_real_id.search

          expect(result.title).to eq(real_title)
          expect(result.release_date).to include(release_year)
          expect(result.imdb_id).to_not be_nil
          expect(result.genres).to be_an Array
        end
      end

      it 'returns an error object if external id is not recognized' do
        VCR.use_cassette('fake_id_movie_search') do
          result = movie_search_with_fake_id.search

          expect(result[:status_message]).to include("Invalid id")
        end
      end
    end
  end
end
