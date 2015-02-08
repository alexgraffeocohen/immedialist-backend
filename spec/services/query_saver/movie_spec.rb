require 'rails_helper'

RSpec.describe QuerySaver::Movie, type: :service do
  let(:query_results) { TestQuery::Movie.new.call_with_real_name }
  let(:sanitized_query_results) { QuerySanitizer::Movie.call(query_results) }

  it_behaves_like 'a query saver', Movie, FactoryGirl.build(:real_movie)
end
