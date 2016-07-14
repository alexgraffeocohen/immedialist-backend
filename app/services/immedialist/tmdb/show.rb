module Immedialist
  module TMDB
    class Show < TMDBResource
      def self.search(show_name)
        Tmdb::TV.find(show_name).
          map(&:as_json).
          map do |show_attributes|
            new(show_attributes)
          end
      end

      def actors
        show_cast.map do |actor_attributes|
          Immedialist::TMDB::Person.new(actor_attributes)
        end
      end

      def creators
        show_creators = query_result[:created_by].map(&:symbolize_keys)
        show_creators.each do |creator_attributes|
          creator_attributes.delete(:profile_path)
          creator_attributes[:tmdb_id] = creator_attributes.delete(:id)
        end

        show_creators
      end

      def poster_link
        poster_path = query_result[:poster_path]
        "https://image.tmdb.org/t/p/original#{poster_path}"
      end

      private

      def query_api
        ::Tmdb::TV.detail(tmdb_id)
      end

      def show_cast
        @show_cast ||= ::Tmdb::TV.cast(tmdb_id)
        raise TMDB::QueryError if !@show_cast.is_a?(Array)
        @show_cast
      end

      def active_attributes
        [
          :episode_run_time,
          :first_air_date,
          :homepage,
          :tmdb_id,
          :in_production,
          :last_air_date,
          :name,
          # :networks,
          :number_of_episodes,
          :number_of_seasons,
          :original_language,
          :overview,
          :poster_link,
          :status
        ]
      end
    end
  end
end
