require 'rails_helper'

describe BookSearch do
  let(:book_search_with_real_title) { BookSearch.new(title: real_title) }
  let(:book_search_with_fake_title) { BookSearch.new(title: fake_title) }
  let(:book_search_with_real_id)    { BookSearch.new(external_id: real_id) }
  let(:book_search_with_fake_id)    { BookSearch.new(external_id: fake_id) }
  let(:real_title)                  { "The Goldfinch" }
  let(:fake_title)                  { "The Greatest Book in The World: This is a Tribute" }
  let(:real_id)                     { "17333223" }
  let(:isbn)                        { "0316055433" }
  let(:fake_id)                     { "ithinkicanithinkicanithinkican" }

  describe '#search' do
    context 'with a title' do
      it 'returns an array of book results if there is a match' do
        VCR.use_cassette('real_title_book_search') do
          result = book_search_with_real_title.search

          expect(result.results.work).to be_an Array
          expect(result.results.work.first.best_book.title).to eq(real_title)
        end
      end

      it 'returns an empty array if there is no match' do
        VCR.use_cassette('fake_title_book_search') do
          result = book_search_with_fake_title.search

          expect(result.total_results).to eq('0')
        end
      end
    end

    context 'with an external id' do
      it 'returns a detailed book record if external id is recognized' do
        VCR.use_cassette('real_id_book_search') do
          result = book_search_with_real_id.search

          expect(result.title).to eq(real_title)
          expect(result.isbn).to eq(isbn)
        end
      end

      it 'returns an error object if external id is not recognized' do
        VCR.use_cassette('fake_id_book_search') do
          expect { book_search_with_fake_id.search }.to raise_exception(NoMethodError)
        end
      end
    end
  end
end
