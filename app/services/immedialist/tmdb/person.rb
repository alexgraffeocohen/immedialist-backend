module Immedialist
  module TMDB
    class Person < Resource
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
