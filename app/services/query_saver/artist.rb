class QuerySaver::Artist < QuerySaver
  def call
    artists = build_artists
    artists.each(&:save!)
  end

  private

  def build_artists
    results.map do |artist_result|
      ::Creator.new(
        name: artist_result.fetch(:name),
        spotify_id: artist_result.fetch(:id)
      )
    end
  end
end
