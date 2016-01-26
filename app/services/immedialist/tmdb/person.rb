module Immedialist
  module TMDB
    class Person < TMDBResource
      private

      def active_attributes
        [
          :id,
          :name
        ]
      end
    end
  end
end
