module Immedialist
  module Spotify
    class Artist < SpotifyResource
      RSPOTIFY_CLASS = RSpotify::Artist

      def self.search(artist_name)
        # FIXME: the returned instances cannot have #albums called on them
        # until #find is called. this is because #api_object is not set.
        super(artist_name, RSPOTIFY_CLASS)
      end

      def albums
        @albums ||= download_albums
      end

      private

      def rspotify_class
        RSPOTIFY_CLASS
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
