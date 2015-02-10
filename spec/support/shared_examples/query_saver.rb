RSpec.shared_examples "a query saver" do |item_type, associations|
  item_name = item_type.name.downcase

  let(:query_results) { TestQuery.const_get(item_type.name).new.call_with_real_name }
  let(:sanitized_query_results) { QuerySanitizer.const_get(item_type.name).call(query_results) }

  let(:real_item_factory)  { FactoryGirl.build("real_#{item_name}") }

  let(:saved_items) { described_class.call(sanitized_query_results) }
  let(:saved_item)  { item_type.associated_class.find_by(name: real_item_factory.name) }

  before(:each) do
    saved_items
  end

  it "returns #{item_name.pluralize} based on query data" do
    expect(saved_items).to be_an(Array)
    expect(saved_items.first).to be_a(item_type.associated_class)
  end

  it "saves the #{item_name.pluralize}" do
    expect(saved_item).to_not be_nil
    expect(saved_item).to be_persisted
  end

  if associations
    associations.each do |association|
      it "saves the associated #{association} and links to #{item_name}" do
        db_response = saved_item.send(association)
        Array(db_response).each do |associated_item|
          expect(associated_item).to be_persisted
        end
      end
    end
  end
end
