class MovieTester
  def self.query_with_results
    Query::Movie.new(name: "The Matrix")
  end

  def self.query_with_results_cassette
    'real_name_movie_query'
  end

  def self.query_with_no_results
    Query::Movie.new(name: "There Are No Results For Sure")
  end

  def self.query_with_no_results_cassette
    'no_results_movie_query'
  end
end
