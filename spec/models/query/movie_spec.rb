require 'rails_helper'

describe Query::Movie do
  let(:movie_query_with_real_name)  { Query::Movie.new(name: real_name) }
  let(:movie_query_with_fake_name)  { Query::Movie.new(name: non_existant_name) }
  let(:movie_query_with_real_id)    { Query::Movie.new(external_id: real_id) }
  let(:movie_query_with_fake_id)    { Query::Movie.new(external_id: fake_id) }
  let(:real_name)                   { "The Matrix" }
  let(:release_year)                { "1999" }
  let(:non_existant_name)           { "There Are No Results For Sure" }
  let(:real_id)                     { 603 }
  let(:fake_id)                     { 90909090 }

  describe '#call' do
    context 'with a name' do
      it 'returns an array of movie results if there is a match' do
        VCR.use_cassette('real_name_movie_query') do
          result = movie_query_with_real_name.call

          expect(result).to be_an Array
          expect(result.first.title).to eq(real_name)
          expect(result.first.release_date).to include(release_year)
          expect(result.first.id).to_not be_nil
        end
      end

      it 'returns an empty array if there is no match' do
        VCR.use_cassette('no_results_movie_query') do
          result = movie_query_with_fake_name.call

          expect(result).to be_an Array
          expect(result).to be_empty
        end
      end
    end

    context 'with an external id' do
      it 'returns a detailed movie record if external id is recognized' do
        VCR.use_cassette('real_id_movie_query') do
          result = movie_query_with_real_id.call

          expect(result.title).to eq(real_name)
          expect(result.release_date).to include(release_year)
          expect(result.imdb_id).to_not be_nil
          expect(result.genres).to be_an Array
        end
      end

      it 'returns an error object if external id is not recognized' do
        VCR.use_cassette('fake_id_movie_query') do
          result = movie_query_with_fake_id.call

          expect(result[:status_message]).to include("Invalid id")
        end
      end
    end
  end
end
