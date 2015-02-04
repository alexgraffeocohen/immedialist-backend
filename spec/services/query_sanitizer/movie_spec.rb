require 'rails_helper'

RSpec.describe QuerySanitizer::Movie, type: :service do
  context 'when query has multiple results' do
    let(:query) { MovieTester.query_with_results }
    let(:vcr_cassette) { MovieTester.query_with_results_cassette }
    let(:query_results) { call_query_with_cassette(vcr_cassette) }

    it_behaves_like "a query sanitizer with results"
  end

  context 'when query has no results' do
    let(:query) { MovieTester.query_with_no_results }
    let(:vcr_cassette) { MovieTester.query_with_no_results_cassette }
    let(:query_results) { call_query_with_cassette(vcr_cassette) }

    it_behaves_like "a query sanitizer with no results"
  end
end
