class QuerySanitizer::Song < QuerySanitizer
  private

  def compare_results_to_api_expectations
    spotify_api_expectations_for("Track")
  end

  def sanitize_results
    results.map(&:as_json).map(&:deep_symbolize_keys)
  end
end
