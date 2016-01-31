module Immedialist
  module TMDB
    class Person < TMDBResource
      private

      def active_attributes
        [
          :tmdb_id,
          :name
        ]
      end
    end
  end
end
