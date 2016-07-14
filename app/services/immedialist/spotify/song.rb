module Immedialist
  module Spotify
    class Song < SpotifyResource
      def self.search(song_name)
        RSpotify::Track.search(song_name).
          map(&:as_json).
          map do |song_attributes|
            new(song_attributes)
          end
      end

      def artists
        query_result[:artists].map do |artist_attributes|
          Immedialist::Spotify::Artist.new(artist_attributes)
        end
      end

      def album
        Immedialist::Spotify::Album.new(query_result[:album])
      end

      def spotify_preview_url
        query_result[:preview_url]
      end

      private

      def query_api
        begin
          @api_object = RSpotify::Track.find(spotify_id)
          compare_results_to_api_expectations!
        rescue RestClient::ResourceNotFound
          raise Spotify::ResourceNotFound,
            "Couldn't find Song with ID #{spotify_id}"
        end
      end

      def active_attributes
        [
          :duration_ms,
          :name,
          :spotify_preview_url,
          :spotify_url,
          :spotify_id,
          :disc_number,
          :track_number,
          :spotify_popularity
        ]
      end

      def compare_results_to_api_expectations!
        if !api_object.is_a?(RSpotify::Track)
          raise TypeError, "Query result is not an RSpotify::Track. It is a #{query_result.class}"
        end
      end
    end
  end
end
