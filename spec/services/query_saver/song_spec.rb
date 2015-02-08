require 'rails_helper'

RSpec.describe QuerySaver::Song, type: :service do
  let(:query_results) { TestQuery::Song.new.call_with_real_name }
  let(:sanitized_query_results) { QuerySanitizer::Song.call(query_results) }

  it_behaves_like 'a query saver', Song, FactoryGirl.build(:real_song)
end
