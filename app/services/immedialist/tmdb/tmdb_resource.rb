module Immedialist
  module TMDB
    class TMDBResource < APIResource
      attr_reader :tmdb_id

      def initialize(attributes)
        @query_result = attributes.symbolize_keys
        @tmdb_id = @query_result[:id]
      end

      def find
        @query_result = query_api.try(:symbolize_keys)
        compare_results_to_api_expectations!
        self
      end

      def method_missing(method_name)
        if active_attributes.include?(method_name)
          return query_result[method_name]
        else
          super
        end
      end

      def genres
        if query_result[:genres]
          query_result[:genres].map do |genre_hash|
            Immedialist::TMDB::Genre.new(genre_hash)
          end
        else
          []
        end
      end

      private

      attr_reader :query_result

      def compare_results_to_api_expectations!
        if !query_result.is_a?(Hash)
          raise TypeError, "Query result is not a Hash"
        end

        if query_result["status_code"] == 34
          raise TMDB::QueryError,
            "TMDB could not find a movie with ID #{tmdb_id}"
        end
      end
    end
  end
end
