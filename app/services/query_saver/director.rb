class QuerySaver::Director < QuerySaver
  def call
    directors = build_directors
    directors.each(&:save!)
  end

  private

  def build_directors
    results.map do |director_result|
      ::Creator.new(
        name: director_result.fetch(:name),
        tmdb_id: director_result.fetch(:id)
      )
    end
  end
end
