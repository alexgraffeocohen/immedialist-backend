class MovieSearch < Search
  def search
    if no_external_id_provided
      search_by_title
    else
      search_by_id
    end
  end

  private

  def search_by_title
    FilmQuerier.search_by_movie_title(title)
  end

  def search_by_id
    FilmQuerier.search_by_movie_id(external_id)
  end
end
