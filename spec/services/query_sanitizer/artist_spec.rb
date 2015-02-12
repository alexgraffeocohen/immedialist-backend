require 'rails_helper'

RSpec.describe QuerySanitizer::Artist, type: :service do
  it_behaves_like "a query sanitizer", TestQuery::Artist.new
end
