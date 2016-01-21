module Immedialist
  module RottenTomatoes
    include ::RottenTomatoes
    Rotten.api_key = Figaro.env.rotten_tomatoes_api_key

    class QueryError < StandardError; end

    def query_movie_by_imdb_id(imdb_id)
      RottenMovie.find(imdb: String(imdb_id))
    end
  end
end
