module UpdateItem
  class Creator < UpdateItem::Base
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
      update_genres! if spotify_artist.music_genres.present?
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

    def update_tmdb_association!(model_name, join_model_name, association_name)
      update_association!(tmdb_person, "tmdb_id", model_name, join_model_name, association_name)
    end

    def update_albums!
      update_spotify_association!(Album, "artist_albums", "albums")
    end

    def update_genres!
      update_spotify_association!(MusicGenre, "artist_genres", "music_genres")
    end

    def update_spotify_association!(model_name, join_model_name, association_name)
      update_association!(spotify_artist, "spotify_id", model_name, join_model_name, association_name)
    end
  end
end
