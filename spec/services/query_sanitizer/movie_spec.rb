require 'rails_helper'

RSpec.describe QuerySanitizer::Movie, type: :service do
  context 'when query has multiple results' do
    let(:query) { Query::Movie.new(name: "The Matrix") }
    let(:query_results) { call_query_with_cassette('real_name_movie_query') }

    it_behaves_like "a query sanitizer with results"
  end

  context 'when query has no results' do
    let(:query) { Query::Movie.new(name: "There Are No Results For Sure") }
    let(:query_results) { call_query_with_cassette('no_results_movie_query') }

    it_behaves_like "a query sanitizer with no results"
  end
end
