module Immedialist
  module Spotify
    class SpotifyResource < APIResource
      attr_reader :spotify_id

      def self.search(resource_name, rspotify_class)
        rspotify_class.search(resource_name).
          map(&:as_json).
          map do |resource_attributes|
            new(resource_attributes)
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

      def spotify_url
        query_result[:external_urls][:spotify]
      end

      def spotify_popularity
        query_result[:popularity]
      end

      private

      attr_reader :query_result, :api_object

      def rspotify_class
        raise NotImplementedError
      end

      def query_api
        begin
          @api_object = rspotify_class.find(spotify_id)
          compare_results_to_api_expectations!
        rescue RestClient::ResourceNotFound
          raise Spotify::ResourceNotFound,
            "Couldn't find #{rspotify_class} with ID #{spotify_id}"
        end
      end

      def sanitize_result
        @query_result = api_object.as_json.deep_symbolize_keys
      end

      def compare_results_to_api_expectations!
        if !api_object.is_a?(rspotify_class)
          raise TypeError, "Query result is not an #{rspotify_class}. It is a #{query_result.class}"
        end
      end
    end
  end
end
