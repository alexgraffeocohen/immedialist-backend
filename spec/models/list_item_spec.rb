require 'rails_helper'

RSpec.describe ListItem, :type => :model do
  let(:list_item) { FactoryGirl.build(:list_item) }

  it { should have_one(:search).dependent(:destroy) }
  it { should belong_to(:user) }
  it { should belong_to(:item) }

  it { should validate_presence_of(:name) }

  it_behaves_like 'it can be converted to an item type',
    FactoryGirl.build(:list_item)

  describe '#before_update' do
    before(:each) {
      list_item.save!
      FactoryGirl.create(:search, list_item: list_item)
    }

    context 'item has not been updated' do
      it 'does not delete its search or item' do
        list_item.name = "Just Updating The Name"
        list_item.save!

        expect(list_item.search).to_not be_nil
        expect(list_item.item).to_not be_nil
      end
    end

    context 'item has been updated to a real media item' do
      it 'deletes its search' do
        list_item.item = FactoryGirl.create(:movie)
        list_item.save!

        requested_items_assigned_to_list_item = RequestedItem.
          select { |item|
          item.list_item == list_item
        }

        expect(list_item.search).to be_nil
        expect(Search.where(list_item: list_item)).to be_empty
        expect(requested_items_assigned_to_list_item).to be_empty
      end
    end
  end
end
