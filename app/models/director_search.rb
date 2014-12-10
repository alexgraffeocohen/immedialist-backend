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
    ::Tmdb::Person.find(name)
  end

  def search_by_id
    ::Tmdb::Person.detail(external_id)
  end
end
