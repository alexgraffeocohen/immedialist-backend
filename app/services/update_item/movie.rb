class UpdateItem::Movie < UpdateItem
  private

  def update_item!
    item.assign_attributes(updated_attributes)
    update_genres! if tmdb_movie.genres.present?
    update_actors! if tmdb_movie.actors.present?
    update_directors! if tmdb_movie.directors.present?
    item.save!
  end

  def updated_attributes
    rotten_tomatoes_movie.attributes.merge(tmdb_movie.attributes)
  end

  def rotten_tomatoes_movie
    Immedialist::RottenTomatoes::Movie.find(imdb_id)
  end

  def imdb_id
    tmdb_movie.imdb_id
  end

  def tmdb_movie
    @tmdb_movie ||= Immedialist::TMDB::Movie.find(item.tmdb_id)
  end

  def update_genres!
    update_association!(tmdb_movie, :tmdb_id, Genre, "movie_genres", "genres")
  end

  def update_actors!
    update_association!(tmdb_movie, :tmdb_id, ::Creator, "movie_actors", "actors")
  end

  def update_directors!
    update_association!(tmdb_movie, :tmdb_id, ::Creator, "movie_directors", "directors")
  end
end
