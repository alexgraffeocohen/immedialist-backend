class AlbumSearch < MediaSearch
  private

  def search_by_title
    MusicQuerier.search_by_album_title(title)
  end

  def search_by_external_id
    MusicQuerier.search_by_album_id(external_id)
  end
end
