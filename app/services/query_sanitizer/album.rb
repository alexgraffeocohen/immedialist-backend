class QuerySanitizer::Album < QuerySanitizer
  private

  def compare_results_to_api_expectations
    results.is_a?(Array) or raise TypeError, "Results is not an array"
    return [] if results.empty?
    results.first.is_a?(RSpotify::Album) or raise TypeError, "Result is not a Spotify Album object"
  end

  def sanitize_results
    results.map(&:as_json).map(&:deep_symbolize_keys)
  end
end
