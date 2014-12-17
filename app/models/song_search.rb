class SongSearch < MediaSearch
  private

  def search_by_title
    MusicQuerier.search_by_song_title(title)
  end

  def search_by_external_id
    MusicQuerier.search_by_song_id(external_id)
  end
end
