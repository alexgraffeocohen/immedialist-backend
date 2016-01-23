module Immedialist
  module TMDB
    class Genre
      attr_reader :name, :tmdb_id

      def initialize(attributes)
        @name = attributes["name"]
        @tmdb_id = attributes["id"]
      end
    end
  end
end
