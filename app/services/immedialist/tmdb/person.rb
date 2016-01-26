module Immedialist
  module TMDB
    class Person < APIResource
      def initialize(attributes)
        @query_result = attributes.symbolize_keys
        @tmdb_id = @query_result[:id]
      end

      def method_missing(method_name)
        if active_attributes.include?(method_name)
          return query_result[method_name]
        else
          super
        end
      end

      private

      attr_reader :tmdb_id, :query_result

      def active_attributes
        [
          :id,
          :name
        ]
      end

      def compare_results_to_api_expectations!
      end
    end
  end
end
