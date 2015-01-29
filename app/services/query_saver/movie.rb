class QuerySaver::Movie < QuerySaver
  def call
    movies = build_movies
    movies.each(&:save!)
  end

  private

  def build_movies
    results.is_a?(Array) or raise TypeError, "Results is not an array"
    results.map do |movie_result|
      ::Movie.new(
        name: movie_result.title,
        release_date: movie_result.release_date,
        tmdb_id: movie_result.id
      )
    end
  end
end
