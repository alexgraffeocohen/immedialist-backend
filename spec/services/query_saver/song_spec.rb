require 'rails_helper'

RSpec.describe QuerySaver::Song, type: :service do
  it_behaves_like 'a query saver', TestQuery::Song.new, [:album, :artists]
end
