class Query::Album < Query
  private

  def query_by_name
    MusicQuerier.search_by_album_name(name)
  end

  def query_by_external_id
    MusicQuerier.search_by_album_id(external_id)
  end
end
