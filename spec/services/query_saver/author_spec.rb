require 'rails_helper'

RSpec.describe QuerySaver::Author, type: :service do
  it_behaves_like 'a query saver', TestQuery::Author.new
end
