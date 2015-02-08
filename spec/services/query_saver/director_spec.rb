require 'rails_helper'

RSpec.describe QuerySaver::Director, type: :service do
  let(:query_results) { TestQuery::Director.new.call_with_real_name }
  let(:sanitized_query_results) { QuerySanitizer::Director.call(query_results) }

  it_behaves_like 'a query saver', Creator, FactoryGirl.build(:real_director)
end
