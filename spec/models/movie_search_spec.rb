require 'rails_helper'

describe MovieSearch do
  let(:movie_search_with_title)      { MovieSearch.new(title: real_title) }
  let(:movie_search_with_fake_title) { MovieSearch.new(title: fake_title) }
  let(:movie_search_with_real_id)    { MovieSearch.new(external_id: real_id) }
  let(:movie_search_with_fake_id)    { MovieSearch.new(external_id: fake_id) }
  let(:real_title)                   { "The Matrix" }
  let(:fake_title)                   { "When You Bite The Fry, the Fry Bites Back" }
  let(:real_id)                      { 603 }
  let(:fake_id)                      { 9999999999999 }

  describe '#search' do
    context 'with a title' do
      it 'returns an array of movie results if there is a match' do
        result = movie_search_with_title.search

        expect(result).to_not be_empty
        expect(result.first.title).to eq(real_title)
        expect(result.first.release_date).to include("1999")
        expect(result.first.id).to_not be_nil
      end

      it 'returns an empty array if there is no match' do
        result = movie_search_with_fake_title.search

        expect(result).to eq([])
      end
    end

    context 'with an external id' do
      it 'returns one movie with details' do
        result = movie_search_with_real_id.search

        expect(result.title).to eq(real_title)
        expect(result.release_date).to include("1999")
        expect(result.imdb_id).to_not be_nil
      end

      it 'returns itself if external id does not match' do
        result = movie_search_with_fake_id

        expect(result).to eq(movie_search_with_fake_id)
      end
    end
  end

  describe '#result' do
    it 'returns the result from a search' do
      search_results = movie_search_with_real_id.search

      expect(movie_search_with_real_id.result).to eq(search_results)
    end
  end
end
