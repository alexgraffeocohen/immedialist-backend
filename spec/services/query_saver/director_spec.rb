require 'rails_helper'

RSpec.describe QuerySaver::Director, type: :service do
  it_behaves_like 'a query saver', Immedialist::ItemType::Director.new
end
