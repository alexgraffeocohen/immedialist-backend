class QuerySaver::Album < QuerySaver
  def call
    albums = build_albums
    albums.each(&:save!)
  end

  private

  def build_albums
    results.map do |album_result|
      ::Album.new(
        name: album_result.fetch(:name),
        release_date: album_result.fetch(:release_date),
        spotify_id: album_result.fetch(:id)
      )
    end
  end
end
