module Immedialist
  module TMDB
    class Person < APIResource
      def initialize(attributes)
        @tmdb_id = attributes["id"]
        @query_result = attributes
      end

      def method_missing(method_name)
        if active_attributes.include?(method_name)
          return query_result[method_name.to_s]
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
