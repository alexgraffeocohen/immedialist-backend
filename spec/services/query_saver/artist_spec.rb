require 'rails_helper'

RSpec.describe QuerySaver::Artist, type: :service do
  it_behaves_like 'a query saver', TestQuery::Artist.new
end
