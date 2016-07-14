module Immedialist
  module Spotify
    class SpotifyResource < APIResource
      attr_reader :spotify_id

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

      def spotify_url
        query_result[:external_urls]["spotify"]
      end

      def spotify_popularity
        query_result[:popularity]
      end

      private

      attr_reader :query_result, :api_object
    end
  end
end
