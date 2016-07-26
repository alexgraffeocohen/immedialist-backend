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
    update_albums! if spotify_artist.albums.present?
    update_genres! if spotify_artist.genres.present?
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
    tmdb_person.send(association_name).each do |tmdb_resource|
      resource_in_db = media_class.find_by(
        tmdb_id: tmdb_resource.tmdb_id
      )

      if resource_in_db
        item.send(join_model_name).find_or_create_by!(
          media_class.name.downcase => resource_in_db
        )
      else
        item.send(association_name) << media_class.
          create!(tmdb_resource.attributes)
      end
    end
  end

  def update_albums!
    update_spotify_association!("albums", Album)
  end

  def update_genres!
    update_spotify_association!("genres", MusicGenre)
  end

  def update_spotify_association!(spotify_association, class_name)
    class_association = class_name.table_name

    spotify_artist.send(spotify_association).each do |spotify_resource|
      resource_in_db = class_name.find_by(
        spotify_id: spotify_resource.spotify_id
      )

      if resource_in_db
        item.send("artist_#{spotify_association}").find_or_create_by!(
          class_association.singularize => resource_in_db
        )
      else
        item.send(class_association) << class_name.
          create!(spotify_resource.attributes)
      end
    end
  end
end
