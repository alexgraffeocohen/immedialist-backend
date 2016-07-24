module Immedialist
  module Spotify
    class Genre
      attr_reader :name

      def initialize(name)
        @name = name.titleize
      end

      def spotify_id
        name.gsub(" ","_").downcase
      end

      def attributes
        {
          name: name,
          spotify_id: spotify_id
        }
      end
    end
  end
end
