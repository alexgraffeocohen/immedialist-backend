RSpec.shared_examples 'it can be converted to an item type' do |class_instance|
  it "can convert to an item type" do
    expect(class_instance.to_item_type).to be_a(Immedialist::ItemType)
  end
end
