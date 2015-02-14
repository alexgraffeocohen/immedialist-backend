require 'rails_helper'

RSpec.describe QuerySanitizer::Book, type: :service do
  it_behaves_like "a query sanitizer", TestQuery::Book.new
end
