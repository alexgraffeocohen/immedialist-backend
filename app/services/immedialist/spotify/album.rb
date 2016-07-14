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

      def query_api
        begin
          @api_object = RSpotify::Album.find(spotify_id)
          compare_results_to_api_expectations!
        rescue RestClient::ResourceNotFound
          raise Spotify::ResourceNotFound, "Couldn't find Album with ID #{spotify_id}"
        end
      end

      def sanitize_result
        @query_result = api_object.as_json.deep_symbolize_keys
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

      def compare_results_to_api_expectations!
        if !api_object.is_a?(RSpotify::Album)
          raise TypeError, "Query result is not an RSpotify::Album. It is a #{query_result.class}"
        end
      end
    end
  end
end
