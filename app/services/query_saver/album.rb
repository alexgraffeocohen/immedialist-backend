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
        spotify_id: album_result.fetch(:id),
        cover_url: grab_cover_url(album_result)
      )
    end
  end

  def grab_cover_url(album_result)
    images = album_result.fetch(:images)

    if images
      images.sort { |h, other_h| other_h[:height] <=> h[:height] }.
        first.
        fetch(:url)
    end
  end
end
