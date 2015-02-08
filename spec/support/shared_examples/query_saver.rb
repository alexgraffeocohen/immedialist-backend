RSpec.shared_examples "a query saver" do |model_class, model_factory|
  let(:saved_objects) { described_class.call(sanitized_query_results) }

  before(:each) do
    saved_objects
  end

  it 'returns objects based on query data' do
    expect(saved_objects).to be_an(Array)
    expect(saved_objects.first).to be_a(model_class)
  end

  it 'saves the objects' do
    object_to_find = model_class.where(name: model_factory.name).first

    expect(object_to_find).to_not be_nil
  end
end
