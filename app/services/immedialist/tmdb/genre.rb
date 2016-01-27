module Immedialist
  module TMDB
    class Genre < TMDBResource
      private

      def active_attributes
        [
          :name,
          :tmdb_id
        ]
      end
    end
  end
end
