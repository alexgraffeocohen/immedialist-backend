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
    ::Tmdb::Movie.find(title)
  end

  def search_by_id
    ::Tmdb::Movie.detail(external_id)
  end
end
