require 'rails_helper'

describe Query::Book do
  let(:test_query) { TestQuery::Book.new }
  let(:real_book)  { build(:real_book) }
  let(:fake_book)  { build(:fake_book) }

  describe '#call' do
    context 'with a name' do
      it 'returns a Hashie object with an array of book results' do
        result = test_query.call_with_real_name

        expect(result.results.work).to be_an(Array)
        expect(result.results.work.first.best_book.title).to eq(real_book.name)
      end

      it 'retuns a Hashie object with total results set to zero when there are no results' do
        result = test_query.call_with_fake_name

        expect(result.total_results).to eq('0')
      end
    end

    context 'with an external id' do
      it 'returns a detailed book record if external id is recognized' do
        result = test_query.call_with_real_id

        expect(result.title).to eq(real_book.name)
        expect(result.isbn).to eq(real_book.isbn)
      end

      it 'raises a NoMethodError when external id is not recognized' do
        expect { test_query.call_with_fake_id }.to raise_exception(NoMethodError)
      end
    end
  end
end
