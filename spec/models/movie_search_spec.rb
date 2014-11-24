require 'rails_helper'

describe MovieSearch do
  let(:movie_search_with_title) { MovieSearch.new(title: "The Matrix") }
  let(:movie_search_with_id)    { MovieSearch.new(search_id: 603) }

  describe '#search' do
    context 'with a title' do
      it 'returns movie results' do
        result = movie_search_with_title.search

        expect(result).to_not be_empty
        expect(result.first.title).to eq("The Matrix")
        expect(result.first.release_date).to include("1999")
        expect(result.first.id).to_not be_nil
      end
    end

    context 'with an id' do
      it 'returns one movie with details' do
        result = movie_search_with_id.search

        expect(result.title).to eq("The Matrix")
        expect(result.release_date).to include("1999")
        expect(result.imdb_id).to_not be_nil
      end
    end
  end

end
