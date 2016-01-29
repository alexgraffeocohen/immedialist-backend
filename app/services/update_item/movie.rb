class UpdateItem::Movie < UpdateItem
  private

  def update_item!
    item.assign_attributes(updated_attributes)
    update_genres!(tmdb_movie, :tmdb_id) if tmdb_movie.genres.present?
    update_actors!(tmdb_movie, :tmdb_id) if tmdb_movie.actors.present?
    update_directors!(tmdb_movie, :tmdb_id) if tmdb_movie.directors.present?
    item.save!
  end

  def updated_attributes
    rotten_tomatoes_movie.attributes.merge(tmdb_movie.attributes)
  end

  def rotten_tomatoes_movie
    Immedialist::RottenTomatoes::Movie.find(imdb_id)
  end

  def tmdb_movie
    @tmdb_movie ||= Immedialist::TMDB::Movie.find(item.tmdb_id)
  end

  def imdb_id
    tmdb_movie.imdb_id
  end
end
