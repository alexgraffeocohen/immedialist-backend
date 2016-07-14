module Immedialist
  module TMDB
    class Person < TMDBResource
      def self.search(name)
        Tmdb::Person.find(name).
          map(&:as_json).
          map do |person_attributes|
            new(person_attributes)
          end
      end

      def date_of_birth
        query_result[:birthday]
      end

      def movies_acted_in
        movie_credits.map { |credit_attributes|
          Immedialist::TMDB::Movie.new(
            credit_attributes.slice("title", "id")
          )
        }
      end

      def shows_acted_in
        tv_credits.map { |credit_attributes|
          Immedialist::TMDB::Show.new(
            credit_attributes.slice("name", "id")
          )
        }
      end

      def movies_directed
        director_jobs.map { |director_job_attributes|
          Immedialist::TMDB::Movie.new(
            director_job_attributes.slice("title", "id")
          )
        }
      end

      private

      def active_attributes
        [
          :tmdb_id,
          :name,
          :date_of_birth
        ]
      end

      private

      def query_api
        ::Tmdb::Person.detail(tmdb_id)
      end

      def person_credits
        @person_credits ||= ::Tmdb::Person.credits(tmdb_id)
        raise TMDB::QueryError if !@person_credits.is_a?(Hash)
        @person_credits
      end

      def movie_credits
        person_credits["cast"].select { |cast_attributes|
          cast_attributes["media_type"] == "movie"
        }
      end

      def tv_credits
        person_credits["cast"].select { |cast_attributes|
          cast_attributes["media_type"] == "tv"
        }
      end

      def director_jobs
        person_credits["crew"].select { |crew_attributes|
          crew_attributes["media_type"] == "movie" &&
            crew_attributes["job"] == "Director"
        }
      end
    end
  end
end
