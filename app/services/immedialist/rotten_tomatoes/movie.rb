module Immedialist
  module RottenTomatoes
    class Movie < APIResource
      include Immedialist::RottenTomatoes

      def initialize(attributes)
        @query_result = attributes.symbolize_keys
        @imdb_id = @query_result[:id]

        raise ArgumentError, "imdb_id can only have digits" if imdb_id =~ /\D/
      end

      def method_missing(method_name)
        if active_attributes.include?(method_name)
          return query_result.send(method_name)
        else
          super
        end
      end

      def critics_score
        query_result.ratings.critics_score
      end

      def audience_score
        query_result.ratings.audience_score
      end

      private

      attr_reader :imdb_id, :query_result

      def query_api
        self.query_movie_by_imdb_id(imdb_id)
      end

      def active_attributes
        [
          :audience_score,
          :critics_consensus,
          :critics_score,
          :mpaa_rating,
        ]
      end

      def compare_results_to_api_expectations!
        if !query_result.is_a?(PatchedOpenStruct)
          raise TypeError, "Query result is not a PatchedOpenStruct. It is a #{query_result.class}"
        end

        if query_result.error.present?
          raise RottenTomatoes::QueryError,
            "RottenTomatoes could not find a movie with ID #{imdb_id}"
        end
      end
    end
  end
end
