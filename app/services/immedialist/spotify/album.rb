module Immedialist
  module Spotify
    class Album < SpotifyResource
      def self.search(album_name)
        RSpotify::Album.search(album_name).
          map(&:as_json).
          map do |album_attributes|
            new(album_attributes)
          end
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

      def rspotify_class_name
        "Album"
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
