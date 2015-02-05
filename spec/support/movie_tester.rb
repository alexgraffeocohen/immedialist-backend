class MovieTester
  include Helpers

  def call_query_with_results
    call_query_with_cassette(query_with_results, results_cassette)
  end

  def call_query_with_no_results
    call_query_with_cassette(query_with_no_results, no_results_cassette)
  end

  private

  def query_with_results
    Query::Movie.new(name: "The Matrix")
  end

  def results_cassette
    'real_name_movie_query'
  end

  def query_with_no_results
    Query::Movie.new(name: "There Are No Results For Sure")
  end

  def no_results_cassette
    'no_results_movie_query'
  end
end
