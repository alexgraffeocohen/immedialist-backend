class DirectorSearch < Search
  def search
    if no_external_id_provided
      search_by_name
    else
      search_by_id
    end
  end

  private

  def search_by_name
    FilmQuerier.search_by_person_name(name)
  end

  def search_by_id
    FilmQuerier.search_by_person_id(external_id)
  end
end
