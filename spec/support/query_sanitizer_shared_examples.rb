RSpec.shared_examples "a query sanitizer with results" do
  let(:sanitized_results) { described_class.call(query_results) }

  context 'when query has results' do
    it 'returns them in an array' do
      expect(sanitized_results).to be_an(Array)
    end

    it 'converts each result into a hash' do
      object_attributes = sanitized_results.first

      expect(object_attributes).to be_a(Hash)
    end
  end
end

RSpec.shared_examples "a query sanitizer with no results" do
  let(:sanitized_results) { described_class.call(query_results) }

  context 'when query has no results' do
    it 'returns with an empty array' do
      expect(sanitized_results).to be_an(Array)
      expect(sanitized_results).to be_empty
    end
  end
end
