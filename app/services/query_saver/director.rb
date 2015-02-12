class QuerySaver::Director < QuerySaver
  private

  def build_objects
    results.map do |director_result|
      ::Creator.new(
        name: director_result.fetch(:name),
        tmdb_id: director_result.fetch(:id)
      )
    end
  end
end
