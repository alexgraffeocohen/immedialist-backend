module Immedialist
  module RottenTomatoes
    class Movie
      include Immedialist::RottenTomatoes

      ACTIVE_ATTRIBUTES = [
        :audience_score,
        :critics_consensus,
        :critics_score,
        :mpaa_rating,
      ]

      def self.find(imdb_id)
        new(imdb_id)
      end

      def initialize(imdb_id)
        raise ArgumentError, "imdb_id can only have digits" if imdb_id =~ /\D/

        @imdb_id = imdb_id
        @query_result = self.query_movie_by_imdb_id(imdb_id)
        compare_results_to_api_expectations!
      end

      def attributes
        {}.tap do |hash|
          ACTIVE_ATTRIBUTES.each do |attribute|
            hash[attribute] = self.send(attribute)
          end
        end
      end

      def method_missing(method_name)
        if ACTIVE_ATTRIBUTES.include?(method_name)
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

      def compare_results_to_api_expectations!
        if !query_result.is_a?(PatchedOpenStruct)
          raise TypeError, "Query result is not a PatchedOpenStruct"
        end

        if query_result.error.present?
          raise RottenTomatoes::QueryError,
            "RottenTomatoes could not find a movie with ID #{imdb_id}"
        end
      end
    end
  end
end
