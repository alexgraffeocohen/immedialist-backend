module Immedialist
  module Spotify
    class Artist < SpotifyResource
      def self.search(artist_name)
        # FIXME: the returned instances cannot have #albums called on them
        # until #find is called. this is because #api_object is not set.
        RSpotify::Artist.search(artist_name).
          map(&:as_json).
          map do |artist_attributes|
            new(artist_attributes)
          end
      end

      def albums
        @albums ||= download_albums
      end

      private

      def rspotify_class_name
        "Artist"
      end

      def active_attributes
        [
          :name,
          :spotify_id,
          :genres
        ]
      end

      def download_albums
        # FIXME: this method blows up if api_object is nil, which can happen
        # with instances returned from .search,
        # Immedialist::Spotify::Song#artists, or
        # Immedialist::Spotify::Album#artists.

        # This will cause a separate API request
        api_object.albums.
          map(&:as_json).
          map do |album|
            Immedialist::Spotify::Album.new(album)
          end
      end
    end
  end
end
