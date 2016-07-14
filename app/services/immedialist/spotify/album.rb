module Immedialist
  module Spotify
    class Album < SpotifyResource
      RSPOTIFY_CLASS = RSpotify::Album

      def self.search(album_name)
        super(album_name, RSPOTIFY_CLASS)
      end

      def artists
        query_result[:artists].map do |artist_attributes|
          Immedialist::Spotify::Artist.new(artist_attributes)
        end
      end

      def songs
        query_result[:tracks_cache].map do |song_attributes|
          Immedialist::Spotify::Song.new(song_attributes)
        end
      end

      def cover_url
        images = query_result.fetch(:images)

        if images
          images.sort { |h, other_h|
            other_h[:height] <=> h[:height]
          }.first.fetch(:url)
        end
      end

      private

      def rspotify_class
        RSPOTIFY_CLASS
      end

      def active_attributes
        [
          :release_date,
          :name,
          :spotify_id,
          :cover_url,
          :total_tracks,
          :spotify_popularity
        ]
      end
    end
  end
end
