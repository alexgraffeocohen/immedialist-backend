class UpdateItem::Movie < UpdateItem
  private

  def update_item!
    item.assign_attributes(updated_attributes)
    update_genres!(tmdb_movie, :tmdb_id) if tmdb_movie.genres.present?
    update_actors! if tmdb_movie.actors.present?
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

  def update_genres!(api_resource, api_identifier)
    join_model_name = "#{item.class.name.downcase}_genres"

    api_resource.genres.each do |api_genre|
      genre = Genre.find_by(
        api_identifier => api_genre.send(api_identifier)
      )

      if genre
        item.send(join_model_name).find_or_create_by!(genre: genre)
      else
        item.genres << Genre.create!(api_genre.attributes)
      end
    end
  end

  def update_actors!
    tmdb_movie.actors.each do |tmdb_actor|
      actor = Creator.find_by(tmdb_id: tmdb_actor.tmdb_id)

      if actor
        item.movie_actors.find_or_create_by!(creator: actor)
      else
        item.actors << Creator.create!(tmdb_actor.attributes)
      end
    end
  end
end
