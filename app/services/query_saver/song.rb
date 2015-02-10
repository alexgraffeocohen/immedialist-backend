class QuerySaver::Song < QuerySaver
  def call
    songs = build_songs
    songs.each(&:save!)
  end

  private

  def build_songs
    results.map do |song_result|
      song = ::Song.new(
        name: song_result.fetch(:name),
        spotify_preview_url: song_result.fetch(:preview_url),
        spotify_id: song_result.fetch(:id)
      )

      album = save_associated_album(song_result)
      song.album = album

      song
    end
  end

  def save_associated_album(song_result)
    album_results = [song_result.fetch(:album)]
    albums = QuerySaver::Album.call(album_results)
    albums.first
  end
end
