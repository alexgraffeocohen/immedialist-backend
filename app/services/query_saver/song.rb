class QuerySaver::Song < QuerySaver
  def call
    songs = build_songs
    songs.each(&:save!)
  end

  private

  def build_songs
    results.map do |song_result|
      ::Song.new(
        name: song_result.fetch(:name),
        spotify_preview_url: song_result.fetch(:preview_url),
        spotify_id: song_result.fetch(:id)
      )
    end
  end
end
