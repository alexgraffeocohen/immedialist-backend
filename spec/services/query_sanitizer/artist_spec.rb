require 'rails_helper'

RSpec.describe QuerySanitizer::Artist, type: :service do
  let(:test_query) { TestQuery::Artist.new }

  context 'when query has multiple results' do
    let(:query_results) { test_query.call_with_real_name }

    it_behaves_like "a query sanitizer with results"
  end

  context 'when query has no results' do
    let(:query_results) { test_query.call_with_fake_name }

    it_behaves_like "a query sanitizer with no results"
  end
end
