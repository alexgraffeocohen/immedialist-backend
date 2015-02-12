class QuerySaver::Movie < QuerySaver
  private

  def build_objects
    results.map do |movie_result|
      ::Movie.new(
        name: movie_result.fetch(:title),
        release_date: movie_result.fetch(:release_date),
        tmdb_id: movie_result.fetch(:id)
      )
    end
  end
end
