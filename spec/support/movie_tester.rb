require 'support/helpers'

class MovieTester
  include Helpers

  def call_query_with_results
    self.query = query_with_results
    call_query_with_cassette(results_cassette)
  end

  def call_query_with_no_results
    self.query = query_with_no_results
    call_query_with_cassette(no_results_cassette)
  end

  def movie_name
    "The Matrix"
  end

  def movie_release_year
    "1999"
  end

  private
  attr_accessor :query

  def query_with_results
    Query::Movie.new(name: movie_name)
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
