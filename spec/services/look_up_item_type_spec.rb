require 'rails_helper'

RSpec.describe LookUpItemType, type: :service do
  it 'returns an item type model based on what user supplied' do
    item_type = LookUpItemType.call('actor')

    expect(item_type).to be_a(Immedialist::ItemType::Actor)
  end
end
