require 'rails_helper'

RSpec.describe QuerySanitizer::Movie, type: :service do
  let(:movie_tester) { MovieTester.new }

  context 'when query has multiple results' do
    let(:query_results) { movie_tester.call_query_with_results }

    it_behaves_like "a query sanitizer with results"
  end

  context 'when query has no results' do
    let(:query_results) { movie_tester.call_query_with_no_results }

    it_behaves_like "a query sanitizer with no results"
  end
end
