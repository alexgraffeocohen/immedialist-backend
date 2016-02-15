module Immedialist
  module Spotify
    class Song < APIResource
      attr_reader :spotify_id

      def self.search(song_name)
        RSpotify::Track.search(song_name).
          map(&:as_json).
          map do |song_attributes|
            new(song_attributes)
          end
      end

      def initialize(attributes)
        @query_result = attributes.symbolize_keys
        @spotify_id = @query_result[:id]
      end

      def find
        query_api
        sanitize_result
        self
      end

      def method_missing(method_name)
        if active_attributes.include?(method_name)
          return query_result[method_name]
        else
          super
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

      private

      attr_reader :query_result

      def query_api
        begin
          @query_result = RSpotify::Track.find(spotify_id)
          compare_results_to_api_expectations!
        rescue RestClient::ResourceNotFound
          raise Spotify::ResourceNotFound,
            "Couldn't find Song with ID #{spotify_id}"
        end
      end

      def sanitize_result
        @query_result = query_result.as_json.symbolize_keys
      end

      def active_attributes
        [
          :duration,
          :name,
          :preview_url,
          :spotify_id,
          :disc_number,
          :track_number
        ]
      end

      def compare_results_to_api_expectations!
        if !query_result.is_a?(RSpotify::Track)
          raise TypeError, "Query result is not a RSpotify::Track"
        end
      end
    end
  end
end
