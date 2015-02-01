require 'rails_helper'

RSpec.describe QuerySaver::Movie, type: :service do
  context 'when query has results' do
    let(:query) { Query::Movie.new(name: "The Matrix") }

    before(:each) do
      VCR.use_cassette('real_name_movie_query') do
        query.call
      end
    end

    it 'returns Movie objects' do
      movies = QuerySaver::Movie.call(query)

      expect(movies).to be_an(Array)
      expect(movies.first).to be_a(Movie)
    end

    it 'saves Movie objects' do
      QuerySaver::Movie.call(query)
      the_matrix = Movie.find_by(tmdb_id: 603)

      expect(the_matrix.name).to eq('The Matrix')
      expect(the_matrix.release_date.year).to eq(1999)
    end
  end
end
