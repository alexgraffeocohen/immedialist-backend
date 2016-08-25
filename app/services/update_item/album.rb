module UpdateItem
  class Album < UpdateItem::Base
    private

    def update_item!
      item.assign_attributes(updated_attributes)
      update_songs!
      update_artists!
      item.save!
    end

    def updated_attributes
      spotify_album.attributes
    end

    def spotify_album
      @spotify_album ||= Immedialist::Spotify::Album.find(item.spotify_id)
    end

    def update_songs!
      # Should I be just replacing all of the songs on the
      # album with whatever the result is from Spotify? If
      # an album goes from having one single to all of its
      # tracks, I could end up with the single version of the
      # song and the full album version associated with my
      # album record.
      #
      # In other words, Spotify should be the source of truth
      # for what songs are in an album.
      spotify_album.songs.each do |spotify_song|
        song_in_db = ::Song.find_by(
          spotify_id: spotify_song.spotify_id
        )

        if song_in_db
          item.songs << song_in_db
        else
          item.songs << ::Song.create!(spotify_song.attributes)
        end
      end
    end

    def update_artists!
      update_association!(spotify_album, :spotify_id, ::Creator, "artist_albums", "artists")
    end
  end
end
