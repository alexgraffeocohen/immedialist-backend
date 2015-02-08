require 'rails_helper'

RSpec.describe QuerySaver::Actor, type: :service do
  let(:query_results) { TestQuery::Actor.new.call_with_real_name }
  let(:sanitized_query_results) { QuerySanitizer::Actor.call(query_results) }

  it_behaves_like 'a query saver', Creator, FactoryGirl.build(:real_actor)
end
