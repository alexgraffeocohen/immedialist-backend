module UpdateItem
  class Song < UpdateItem::Base
    private

    def update_item!
      item.assign_attributes(updated_attributes)
      update_album!
      update_artists!
      item.save!
    end

    def updated_attributes
      spotify_song.attributes
    end

    def spotify_song
      @spotify_song ||= Immedialist::Spotify::Song.find(item.spotify_id)
    end

    def update_album!
      album_in_db = Album.find_by(
        spotify_id: spotify_song.album.spotify_id
      )

      if album_in_db
        item.album = album_in_db
      else
        item.album = Album.create!(spotify_song.album.attributes)
      end
    end

    def update_artists!
      # FIXME: this can likely be refactored to
      # UpdateItem::Album.call(item.album) because a song's artists come from
      # the album, and that service should take care of updating the artsts on
      # the album.
      # Another way to resolve this would be to be able to change `item` within
      # #update_association!, since the logic is identical besides the fact
      # that we have to operate on #album instead of #item. But I think the
      # first idea is cleaner and more comphrensile.
      spotify_song.artists.each do |spotify_artist|
        artist_in_db = ::Creator.find_by(
          spotify_id: spotify_artist.spotify_id
        )

        if artist_in_db
          item.album.artist_albums.find_or_create_by!(
            creator: artist_in_db
          )
        else
          item.album.artists << ::Creator.
            create!(spotify_artist.attributes)
        end
      end
    end
  end
end
