require 'rails_helper'

describe MovieQuery do
  let(:movie_query_with_real_title)  { MovieQuery.new(title: real_title) }
  let(:movie_query_with_fake_title)  { MovieQuery.new(title: fake_title) }
  let(:movie_query_with_real_id)     { MovieQuery.new(external_id: real_id) }
  let(:movie_query_with_fake_id)     { MovieQuery.new(external_id: fake_id) }
  let(:real_title)                   { "The Matrix" }
  let(:release_year)                 { "1999" }
  let(:fake_title)                   { "When You Bite The Fry, the Fry Bites Back" }
  let(:real_id)                      { 603 }
  let(:fake_id)                      { 90909090 }

  describe '#query' do
    context 'with a title' do
      it 'returns an array of movie results if there is a match' do
        VCR.use_cassette('real_title_movie_query') do
          result = movie_query_with_real_title.query

          expect(result).to be_an Array
          expect(result.first.title).to eq(real_title)
          expect(result.first.release_date).to include(release_year)
          expect(result.first.id).to_not be_nil
        end
      end

      it 'returns an empty array if there is no match' do
        VCR.use_cassette('fake_title_movie_query') do
          result = movie_query_with_fake_title.query

          expect(result).to be_an Array
          expect(result).to be_empty
        end
      end
    end

    context 'with an external id' do
      it 'returns a detailed movie record if external id is recognized' do
        VCR.use_cassette('real_id_movie_query') do
          result = movie_query_with_real_id.query

          expect(result.title).to eq(real_title)
          expect(result.release_date).to include(release_year)
          expect(result.imdb_id).to_not be_nil
          expect(result.genres).to be_an Array
        end
      end

      it 'returns an error object if external id is not recognized' do
        VCR.use_cassette('fake_id_movie_query') do
          result = movie_query_with_fake_id.query

          expect(result[:status_message]).to include("Invalid id")
        end
      end
    end
  end
end
