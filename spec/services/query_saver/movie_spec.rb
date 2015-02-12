require 'rails_helper'

RSpec.describe QuerySaver::Movie, type: :service do
  it_behaves_like 'a query saver', TestQuery::Movie.new
end
