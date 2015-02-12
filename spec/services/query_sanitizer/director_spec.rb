require 'rails_helper'

RSpec.describe QuerySanitizer::Director, type: :service do
  it_behaves_like "a query sanitizer", TestQuery::Director.new
end
