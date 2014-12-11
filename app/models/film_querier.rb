class FilmQuerier
  def self.search_by_movie_title(title)
    ::Tmdb::Movie.find(title)
  end

  def self.search_by_movie_id(id)
    ::Tmdb::Movie.detail(id)
  end

  def self.search_by_person_name(name)
    ::Tmdb::Person.find(name)
  end

  def self.search_by_person_id(external_id)
    ::Tmdb::Person.detail(external_id)
  end
end
