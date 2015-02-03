require 'rails_helper'

RSpec.describe QuerySanitizer::Movie, type: :service do
  let(:sanitized_results) { QuerySanitizer::Movie.call(query_results) }
  let(:query_results) do
    VCR.use_cassette('real_name_movie_query') do
      query.call
    end
  end

  context 'when query has multiple results' do
    let(:query) { Query::Movie.new(name: "The Matrix") }

    it 'returns them in an array' do
      expect(sanitized_results).to be_an(Array)
    end

    it 'converts each result into a hash' do
      movie_attributes = sanitized_results.first

      expect(movie_attributes).to be_a(Hash)
    end
  end
end
