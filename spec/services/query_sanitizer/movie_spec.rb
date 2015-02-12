require 'rails_helper'

RSpec.describe QuerySanitizer::Movie, type: :service do
  it_behaves_like "a query sanitizer", TestQuery::Movie.new
end
