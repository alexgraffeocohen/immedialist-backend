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
    spotify_artist.albums.each do |spotify_album|
      album_in_db = Album.find_by(
        spotify_id: spotify_album.spotify_id
      )

      if album_in_db
        item.artist_albums.find_or_create_by!(
          album: album_in_db
        )
      else
        item.albums << Album.create!(spotify_album.attributes)
      end
    end
  end

  def update_genres!
    spotify_artist.genres.each do |spotify_genre|
      genre_in_db = MusicGenre.find_by(
        spotify_id: spotify_genre.spotify_id
      )

      if genre_in_db
        item.artist_genres.find_or_create_by!(
          music_genre: genre_in_db
        )
      else
        item.music_genres << MusicGenre.create!(
          spotify_genre.attributes
        )
      end
    end
  end
end
