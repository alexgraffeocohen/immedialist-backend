class MovieQuery < MediaQuery
  private

  def query_by_title
    FilmQuerier.search_by_movie_title(title)
  end

  def query_by_external_id
    FilmQuerier.search_by_movie_id(external_id)
  end
end
