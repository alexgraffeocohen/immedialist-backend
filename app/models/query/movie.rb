class Query::Movie < Query
  private

  def query_by_name
    FilmQuerier.search_by_movie_name(name)
  end

  def query_by_external_id
    FilmQuerier.search_by_movie_id(external_id)
  end
end
