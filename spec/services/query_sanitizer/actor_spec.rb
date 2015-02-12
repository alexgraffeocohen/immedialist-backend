require 'rails_helper'

RSpec.describe QuerySanitizer::Actor, type: :service do
  it_behaves_like "a query sanitizer", TestQuery::Actor.new
end
