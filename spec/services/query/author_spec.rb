require 'rails_helper'

describe Query::Author do
  let(:test_query)  { TestQuery::Author.new }
  let(:real_author) { build(:real_author) }
  let(:fake_author) { build(:fake_author) }

  describe '#call' do
    context 'with an accurate name' do
      it 'returns the closest author match in a Hashie object' do
        result = test_query.call_with_real_name

        expect(result.name).to eq(real_author.name)
      end

      it 'returns an empty Hashie object if there is no match' do
        result = test_query.call_with_fake_name

        expect(result).to be_empty
      end
    end

    context 'with an external id' do
      it 'returns a detailed author record if external id is recognized' do
        result = test_query.call_with_real_id

        expect(result.name).to eq(real_author.name)
        expect(result.books.book).to be_an Array
      end

      it 'raises an excpection if external id is not recognized' do
        expect { test_query.call_with_fake_id }.to raise_exception(Goodreads::NotFound)
      end
    end
  end
end
