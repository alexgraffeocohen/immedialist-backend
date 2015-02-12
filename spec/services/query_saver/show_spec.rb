require 'rails_helper'

RSpec.describe QuerySaver::Show, type: :service do
  it_behaves_like 'a query saver', TestQuery::Show.new
end
