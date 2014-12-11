class DirectorSearch < PersonSearch
  private

  def search_by_name
    FilmQuerier.search_by_person_name(name)
  end

  def search_by_external_id
    FilmQuerier.search_by_person_id(external_id)
  end
end
