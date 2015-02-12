class QuerySanitizer::Movie < QuerySanitizer
  private

  def compare_results_to_api_expectations
    tmdb_api_expectations_for("Movie")
  end

  def sanitize_results
    results.map(&:as_json).map(&:symbolize_keys)
  end
end
