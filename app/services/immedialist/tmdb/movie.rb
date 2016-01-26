module Immedialist
  module TMDB
    class Movie < APIResource
      def initialize(tmdb_id)
        @tmdb_id = tmdb_id
      end

      def method_missing(method_name)
        if active_attributes.include?(method_name)
          return query_result[method_name.to_s]
        else
          super
        end
      end

      def genres
        query_result["genres"].map do |genre_hash|
          Immedialist::TMDB::Genre.new(genre_hash)
        end
      end

      def actors
        movie_crew["cast"].map do |actor_attributes|
          Immedialist::TMDB::Person.new(actor_attributes)
        end
      end

      def imdb_id
        query_result["imdb_id"].gsub(/\D/,"")
      end

      private

      attr_reader :tmdb_id, :query_result

      def query_api
        ::Tmdb::Movie.detail(tmdb_id)
      end

      def movie_crew
        @movie_crew ||= ::Tmdb::Movie.credits(tmdb_id)
      end

      def active_attributes
        [
          :budget,
          :genres,
          :homepage,
          :imdb_id,
          :original_language,
          :overview,
          :release_date,
          :revenue,
          :runtime,
          :status,
          :title,
          :tmdb_id,
          :tmdb_poster_path,
        ]
      end

      def inactive_attributes
        [
          :adult,
          :belongs_to_collection,
          :original_title,
          :original_title,
          :popularity,
          :production_companies,
          :production_countries,
          :spoken_languages,
          :tagline,
          :video,
          :vote_average,
          :vote_count
        ]
      end

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
