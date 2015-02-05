require 'rails_helper'

RSpec.describe QuerySanitizer::Actor, type: :service do
  let(:actor_tester) { ActorTester.new }

  context 'when query has multiple results' do
    let(:query_results) { actor_tester.call_query_with_results }

    it_behaves_like "a query sanitizer with results"
  end

  context 'when query has no results' do
    let(:query_results) { actor_tester.call_query_with_no_results }

    it_behaves_like "a query sanitizer with no results"
  end
end
