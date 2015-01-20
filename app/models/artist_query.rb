class ArtistQuery < PersonQuery
  private

  def query_by_name
    MusicQuerier.search_by_artist_name(name)
  end

  def query_by_external_id
    MusicQuerier.search_by_artist_id(external_id)
  end
end
