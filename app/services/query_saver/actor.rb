class QuerySaver::Actor < QuerySaver
  def call
    actors = build_actors
    actors.each(&:save!)
  end

  private

  def build_actors
    results.map do |actor_result|
      ::Person.new(
        name: actor_result.fetch(:name),
        tmdb_id: actor_result.fetch(:id)
      )
    end
  end
end
