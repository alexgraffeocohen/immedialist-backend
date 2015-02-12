require 'rails_helper'

RSpec.describe QuerySanitizer::Show, type: :service do
  it_behaves_like "a query sanitizer", TestQuery::Show.new
end
