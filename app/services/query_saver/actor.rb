class QuerySaver::Actor < QuerySaver
  private

  def build_objects
    results.map do |actor_result|
      ::Creator.new(
        name: actor_result.fetch(:name),
        tmdb_id: actor_result.fetch(:id)
      )
    end
  end
end
