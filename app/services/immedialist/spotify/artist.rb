module Immedialist
  module Spotify
    class Artist < APIResource
      attr_reader :spotify_id

      def self.search(artist_name)
        # FIXME: the returned instances cannot have #albums called on them
        # until #find is called. this is because #api_object is not set.
        RSpotify::Artist.search(artist_name).
          map(&:as_json).
          map do |artist_attributes|
            new(artist_attributes)
          end
      end

      def initialize(attributes)
        @query_result = attributes.symbolize_keys
        @spotify_id = @query_result[:id]
      end

      def find
        query_api
        sanitize_result
        self
      end

      def method_missing(method_name)
        if active_attributes.include?(method_name)
          return query_result[method_name]
        else
          super
        end
      end

      def albums
        @albums ||= download_albums
      end

      private

      attr_reader :api_object, :query_result

      def query_api
        begin
          @api_object = RSpotify::Artist.find(spotify_id)
          compare_results_to_api_expectations!
        rescue RestClient::ResourceNotFound
          raise Spotify::ResourceNotFound, "Couldn't find Artist with ID #{spotify_id}"
        end
      end

      def sanitize_result
        @query_result = api_object.as_json.deep_symbolize_keys
      end

      def active_attributes
        [
          :name,
          :spotify_id,
        ]
      end

      def download_albums
        # FIXME: this method blows up if api_object is nil, which can happen
        # with instances returned from .search,
        # Immedialist::Spotify::Song#artists, or
        # Immedialist::Spotify::Album#artists.

        # This will cause a separate API request
        api_object.albums.
          map(&:as_json).
          map do |album|
            Immedialist::Spotify::Album.new(album)
          end
      end

      def compare_results_to_api_expectations!
        if !api_object.is_a?(RSpotify::Artist)
          raise TypeError, "Query result is not an RSpotify::Artist. It is a #{query_result.class}"
        end
      end
    end
  end
end
