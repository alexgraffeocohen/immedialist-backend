require 'rails_helper'

describe AuthorSearch do
  let(:author_search_with_real_name) { AuthorSearch.new(name: real_name) }
  let(:author_search_with_fake_name) { AuthorSearch.new(name: fake_name) }
  let(:author_search_with_real_id)    { AuthorSearch.new(external_id: real_id) }
  let(:author_search_with_fake_id)    { AuthorSearch.new(external_id: fake_id) }
  let(:real_name)                     { "William Faulkner" }
  let(:fake_name)                     { "The Greatest author in The World: This is a Tribute" }
  let(:real_id)                       { "3535" }
  let(:fake_id)                       { "ithinkicanithinkicanithinkican" }

  describe '#search' do
    context 'with an accurate name' do
      it 'returns the closest author match' do
        VCR.use_cassette('real_name_author_search') do
          result = author_search_with_real_name.search

          expect(result.name).to eq(real_name)
        end
      end

      it 'returns nothing if there is no match' do
        VCR.use_cassette('fake_name_author_search') do
          result = author_search_with_fake_name.search

          expect(result).to be_empty
        end
      end
    end

    context 'with an external id' do
      it 'returns a detailed author record if external id is recognized' do
        VCR.use_cassette('real_id_author_search') do
          result = author_search_with_real_id.search

          expect(result.name).to eq(real_name)
          expect(result.books.book).to be_an Array
        end
      end

      it 'returns an error object if external id is not recognized' do
        VCR.use_cassette('fake_id_author_search') do
          expect { author_search_with_fake_id.search }.to raise_exception(Goodreads::NotFound)
        end
      end
    end
  end
end
