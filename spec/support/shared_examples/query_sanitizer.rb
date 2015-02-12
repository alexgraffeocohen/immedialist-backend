RSpec.shared_examples "a query sanitizer" do |test_query|
  let(:sanitized_results) { described_class.call(query_results) }

  context 'when query has results' do
    let(:query_results) { test_query.call_with_real_name }

    it 'returns them in an array' do
      expect(sanitized_results).to be_an(Array)
    end

    it 'converts each result into a hash with symbolized keys' do
      object_attributes = sanitized_results.first

      expect(object_attributes).to be_a(Hash)
      expect(object_attributes.keys.map(&:class).uniq).to eq([Symbol])
    end
  end

  context 'when query has no results' do
    let(:query_results) { test_query.call_with_fake_name }

    it 'returns with an empty array' do
      expect(sanitized_results).to be_an(Array)
      expect(sanitized_results).to be_empty
    end
  end
end
