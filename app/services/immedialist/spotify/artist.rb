module Immedialist
  module Spotify
    class Artist < APIResource
      attr_reader :spotify_id

      def self.search(artist_name)
        RSpotify::Artist.search(artist_name).
          map(&:as_json).
          map do |artist_attributes|
            new(artist_attributes)
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

      def albums
        # requesting albums requires an extra internet request
      end

      private

      attr_reader :api_object, :query_result

      def query_api
        begin
          @api_object = RSpotify::Artist.find(spotify_id)
          compare_results_to_api_expectations!
        rescue RestClient::ResourceNotFound
          raise Spotify::ResourceNotFound, "Couldn't find Artist with ID #{spotify_id}"
        end
      end

      def sanitize_result
        @query_result = api_object.as_json.deep_symbolize_keys
      end

      def active_attributes
        [
          :name,
          :spotify_id,
        ]
      end

      def compare_results_to_api_expectations!
        if !api_object.is_a?(RSpotify::Artist)
          raise TypeError, "Query result is not an RSpotify::Artist. It is a #{query_result.class}"
        end
      end
    end
  end
end
