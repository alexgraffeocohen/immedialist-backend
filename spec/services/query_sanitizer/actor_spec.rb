require 'rails_helper'

RSpec.describe QuerySanitizer::Actor, type: :service do
  context 'when query has multiple results' do
    let(:query) { Query::Actor.new(name: "Keanu Reeves") }
    let(:query_results) { call_query_with_cassette(query, 'real_name_actor_query') }

    it_behaves_like "a query sanitizer with results"
  end

  context 'when query has no results' do
    let(:query) { Query::Actor.new(name: "There Are No Results For Sure") }
    let(:query_results) { call_query_with_cassette(query, 'no_results_actor_query') }

    it_behaves_like "a query sanitizer with no results"
  end
end
