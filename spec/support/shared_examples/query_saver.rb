RSpec.shared_examples "a query saver" do |test_query, associations|
  item_name = test_query.to_item_type.name
  item_names = item_name.downcase.pluralize

  let(:query_results) { test_query.call_with_real_name }
  let(:sanitized_query_results) { QuerySanitizer.const_get(item_name).
                                  call(query_results) }

  let(:real_item_factory)  { FactoryGirl.build("real_#{item_name.downcase}") }

  let(:saved_items) { described_class.call(sanitized_query_results) }
  let(:saved_item)  { test_query.to_item_type.
                      associated_class.
                      find_by(name: real_item_factory.name) }

  before(:each) do
    saved_items
  end

  it "returns #{item_names} based on query data" do
    expect(saved_items).to be_an(Array)
    expect(saved_items.first).to be_a(test_query.to_item_type.associated_class)
  end

  it "saves the #{item_names}" do
    expect(saved_item).to_not be_nil
    expect(saved_item).to be_persisted
  end

  if associations
    associations.each do |association|
      it "saves the associated #{association} and links to the #{item_name.downcase}" do
        db_response = saved_item.send(association)
        Array(db_response).each do |associated_item|
          expect(associated_item).to be_persisted
        end
      end
    end
  end
end
