require 'rails_helper'

RSpec.describe QuerySaver::Movie, type: :service do
  let(:query)  { Query::Movie.new(name: "The Matrix") }
  let(:movies) { QuerySaver::Movie.call(sanitized_query_results) }
  let(:sanitized_query_results) do
    VCR.use_cassette('real_name_movie_query') do
      QuerySanitizer::Movie.call(query.call)
    end
  end

  before(:each) do
    movies
  end

  it 'returns Movie objects based on query data' do
    expect(movies).to be_an(Array)
    expect(movies.first).to be_a(Movie)
  end

  it 'saves the Movie objects' do
    the_matrix = Movie.find_by(tmdb_id: 603)

    expect(the_matrix.name).to eq('The Matrix')
    expect(the_matrix.release_date.year).to eq(1999)
  end
end
