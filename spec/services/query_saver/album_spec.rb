require 'rails_helper'

RSpec.describe QuerySaver::Album, type: :service do
  it_behaves_like 'a query saver', Immedialist::ItemType::Album.new
end
