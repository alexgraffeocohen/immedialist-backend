require 'rails_helper'

describe Query::Book do
  let(:book_query_with_real_name)  { Query::Book.new(name: real_name) }
  let(:book_query_with_fake_name)  { Query::Book.new(name: fake_name) }
  let(:book_query_with_real_id)    { Query::Book.new(external_id: real_id) }
  let(:book_query_with_fake_id)    { Query::Book.new(external_id: fake_id) }
  let(:real_name)                  { "The Goldfinch" }
  let(:fake_name)                  { "The Greatest Book in The World: This is a Tribute" }
  let(:real_id)                    { "17333223" }
  let(:isbn)                       { "0316055433" }
  let(:fake_id)                    { "ithinkicanithinkicanithinkican" }

  describe '#call' do
    context 'with a name' do
      it 'returns an array of book results if there is a match' do
        VCR.use_cassette('real_name_book_query') do
          result = book_query_with_real_name.call

          expect(result.results.work).to be_an Array
          expect(result.results.work.first.best_book.title).to eq(real_name)
        end
      end

      it 'returns an empty array if there is no match' do
        VCR.use_cassette('fake_name_book_query') do
          result = book_query_with_fake_name.call

          expect(result.total_results).to eq('0')
        end
      end
    end

    context 'with an external id' do
      it 'returns a detailed book record if external id is recognized' do
        VCR.use_cassette('real_id_book_query') do
          result = book_query_with_real_id.call

          expect(result.title).to eq(real_name)
          expect(result.isbn).to eq(isbn)
        end
      end

      it 'returns an error object if external id is not recognized' do
        VCR.use_cassette('fake_id_book_query') do
          expect { book_query_with_fake_id.call }.to raise_exception(NoMethodError)
        end
      end
    end
  end
end