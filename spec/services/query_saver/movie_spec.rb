require 'rails_helper'

RSpec.describe QuerySaver::Movie, type: :service do
  describe '#call' do
    it 'returns and saves Movie objects based on query data' do
      VCR.use_cassette('real_name_movie_query') do
        query_results = Query::Movie.new(name: "The Matrix").call
        movies = QuerySaver::Movie.call(query_results)

        expect(movies).to be_an(Array)
        expect(movies.first).to be_a(Movie)

        the_matrix = Movie.find_by(tmdb_id: 603)

        expect(the_matrix.name).to eq('The Matrix')
        expect(the_matrix.release_date.year).to eq(1999)
      end
    end
  end
end
