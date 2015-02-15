require 'rails_helper'

RSpec.describe QuerySanitizer::Author, type: :service do
  it_behaves_like "a query sanitizer", TestQuery::Author.new
end
