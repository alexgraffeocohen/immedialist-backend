require 'rails_helper'

RSpec.describe QuerySanitizer::Song, type: :service do
  it_behaves_like "a query sanitizer", TestQuery::Song.new
end
