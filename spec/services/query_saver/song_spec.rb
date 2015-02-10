require 'rails_helper'

RSpec.describe QuerySaver::Song, type: :service do
  it_behaves_like 'a query saver', Immedialist::ItemType::Song.new, [:album]
end
