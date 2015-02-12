require 'rails_helper'

RSpec.describe QuerySanitizer::Album, type: :service do
  it_behaves_like "a query sanitizer", TestQuery::Album.new
end
