module Immedialist
  module Spotify
    class Album < APIResource
      attr_reader :spotify_id

      def self.search(album_name)
        RSpotify::Album.search(album_name).
          map(&:as_json).
          map do |album_attributes|
            new(album_attributes)
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

      def artists
        query_result[:artists].map do |artist_attributes|
          Immedialist::Spotify::Artist.new(artist_attributes)
        end
      end

      def songs
        query_result[:tracks_cache].map do |song_attributes|
          Immedialist::Spotify::Song.new(song_attributes)
        end
      end

      def cover_url
        images = query_result.fetch(:images)

        if images
          images.sort { |h, other_h|
            other_h[:height] <=> h[:height]
          }.first.fetch(:url)
        end
      end

      private

      attr_reader :query_result

      def query_api
        begin
          @query_result = RSpotify::Album.find(spotify_id)
          compare_results_to_api_expectations!
        rescue RestClient::ResourceNotFound
          raise Spotify::ResourceNotFound, "Couldn't find Album with ID #{spotify_id}"
        end
      end

      def sanitize_result
        @query_result = query_result.as_json.deep_symbolize_keys
      end

      def active_attributes
        [
          :release_date,
          :name,
          :spotify_id,
          :cover_url
        ]
      end

      def compare_results_to_api_expectations!
        if !query_result.is_a?(RSpotify::Album)
          raise TypeError, "Query result is not an RSpotify::Album"
        end
      end
    end
  end
end
