require 'rails_helper'

RSpec.describe RequestedItem, :type => :model do
  it_behaves_like "it can be converted to an item type",
    FactoryGirl.build(:requested_item)
end
