require 'rails_helper'

RSpec.describe QuerySaver::Actor, type: :service do
  it_behaves_like 'a query saver', Immedialist::ItemType::Actor.new
end
