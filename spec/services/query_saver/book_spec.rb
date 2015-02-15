require 'rails_helper'

RSpec.describe QuerySaver::Book, type: :service do
  it_behaves_like 'a query saver', TestQuery::Book.new, [:authors]
end
