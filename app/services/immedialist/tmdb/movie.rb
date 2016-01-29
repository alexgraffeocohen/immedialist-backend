module Immedialist
  module TMDB
    class Movie < TMDBResource
      def self.search(film_title)
        Tmdb::Movie.find(film_title).
          map(&:as_json).
          map do |movie_attributes|
            new(movie_attributes)
          end
      end

      def actors
        movie_crew["cast"].map do |actor_attributes|
          Immedialist::TMDB::Person.new(actor_attributes)
        end
      end

      def directors
        movie_crew["crew"].
          select { |member| member["job"] == "Director" }.
          map { |director_attributes|
            Immedialist::TMDB::Person.new(director_attributes)
          }
      end

      def imdb_id
        query_result[:imdb_id].gsub(/\D/,"") if query_result[:imdb_id]
      end

      private

      def query_api
        ::Tmdb::Movie.detail(tmdb_id)
      end

      def movie_crew
        @movie_crew ||= ::Tmdb::Movie.credits(tmdb_id)
        raise TMDB::QueryError if !@movie_crew.is_a?(Hash)
        @movie_crew
      end

      def active_attributes
        [
          :budget,
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
    end
  end
end
