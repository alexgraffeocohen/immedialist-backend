module Immedialist
  module RottenTomatoes
    class Movie
      include Immedialist::RottenTomatoes

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
        {
          mpaa_rating: mpaa_rating,
          critics_consensus: critics_consensus,
          critics_score: critics_score,
          audience_score: audience_score,
        }
      end

      def mpaa_rating
        query_result.mpaa_rating
      end

      def critics_consensus
        query_result.critics_consensus
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
