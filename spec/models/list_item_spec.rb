require 'rails_helper'

RSpec.describe ListItem, :type => :model do
  let(:list_item) { FactoryGirl.build(:list_item) }

  it { should have_one(:search).dependent(:destroy) }
  it { should belong_to(:user) }
  it { should belong_to(:item) }

  it_behaves_like 'it can be converted to an item type',
    FactoryGirl.build(:list_item)
end
