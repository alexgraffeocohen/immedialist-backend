module Immedialist
  module TMDB
    class QueryError < StandardError; end

    def find_by_tmdb_id(tmdb_id)
      ::Tmdb::Movie.detail(tmdb_id)
    end
  end
end
