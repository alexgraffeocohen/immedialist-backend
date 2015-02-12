class QuerySanitizer::Artist < QuerySanitizer
  private

  def compare_results_to_api_expectations
    spotify_api_expectations_for("Artist")
  end

  def sanitize_results
    results.map(&:as_json).map(&:deep_symbolize_keys)
  end
end
