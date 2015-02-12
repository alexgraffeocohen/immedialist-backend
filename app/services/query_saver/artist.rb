class QuerySaver::Artist < QuerySaver
  private

  def build_objects
    results.map do |artist_result|
      ::Creator.new(
        name: artist_result.fetch(:name),
        spotify_id: artist_result.fetch(:id)
      )
    end
  end
end
