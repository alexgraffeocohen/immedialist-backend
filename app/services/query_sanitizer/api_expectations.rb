module QuerySanitizer::ApiExpectations
  module_function

  def tmdb_api_expectations_for(tmdb_type)
    results.is_a?(Array) or raise TypeError, "Results is not an array"
    throw(:no_results, []) if results.empty?
    results.first.is_a?(Tmdb.const_get(tmdb_type)) or
      raise TypeError, "Result is not a TMDB #{tmdb_type} object"
  end

  def spotify_api_expectations_for(spotify_type)
    results.is_a?(Array) or raise TypeError, "Results is not an array"
    throw(:no_results, []) if results.empty?
    results.first.is_a?(RSpotify.const_get(spotify_type)) or
      raise TypeError, "Result is not a Spotify Track object"
  end
end
