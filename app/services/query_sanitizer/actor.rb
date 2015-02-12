class QuerySanitizer::Actor < QuerySanitizer
  private

  def compare_results_to_api_expectations
    tmdb_api_expectations_for("Person")
  end

  def sanitize_results
    results.map(&:as_json).map(&:symbolize_keys)
  end
end
