class SongQuery < Query
  private

  def query_by_name
    MusicQuerier.search_by_song_name(name)
  end

  def query_by_external_id
    MusicQuerier.search_by_song_id(external_id)
  end
end
