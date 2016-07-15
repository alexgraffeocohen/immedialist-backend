class UpdateItem::Creator < UpdateItem
  private

  def update_item!
    sync_with_tmdb! if item.tmdb_id
    sync_with_spotify! if item.spotify_id
    item.save!
  end

  def updated_attributes
    tmdb_person.attributes
  end

  def sync_with_tmdb!
    item.assign_attributes(tmdb_person.attributes)
    update_movies_acted_in! if tmdb_person.movies_acted_in.present?
    update_movies_directed! if tmdb_person.movies_directed.present?
    update_shows_acted_in!  if tmdb_person.shows_acted_in.present?
  end

  def sync_with_spotify!
    item.assign_attributes(spotify_artist.attributes)
  end

  def tmdb_person
    @tmdb_person ||= Immedialist::TMDB::Person.find(
      item.tmdb_id
    )
  end

  def spotify_artist
    @spotify_artist ||= Immedialist::Spotify::Artist.find(
      item.spotify_id
    )
  end

  def update_movies_acted_in!
    update_tmdb_association!(
      ::Movie, :movie_actors, :movies_acted_in
    )
  end

  def update_movies_directed!
    update_tmdb_association!(
      ::Movie, :movie_directors, :movies_directed
    )
  end

  def update_shows_acted_in!
    update_tmdb_association!(
      ::Show, :show_actors, :shows_acted_in
    )
  end

  def update_tmdb_association!(media_class, join_model_name, association_name)
    tmdb_person.send(association_name).each do |tmdb_movie|
      movie_in_db = media_class.find_by(
        tmdb_id: tmdb_movie.tmdb_id
      )

      if movie_in_db
        item.send(join_model_name).find_or_create_by!(
          media_class.name.downcase => movie_in_db
        )
      else
        item.send(association_name) << media_class.
          create!(tmdb_movie.attributes)
      end
    end
  end
end
