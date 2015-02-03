class QuerySaver::Movie < QuerySaver
  def call
    movies = build_movies
    movies.each(&:save!)
  end

  private

  def build_movies
    results.map do |movie_result|
      ::Movie.new(
        name: movie_result.fetch(:title),
        release_date: movie_result.fetch(:release_date),
        tmdb_id: movie_result.fetch(:id)
      )
    end
  end
end
