class QuerySanitizer::Show < QuerySanitizer
  private

  def compare_results_to_api_expectations
    tmdb_api_expectations_for("TV")
  end

  def sanitize_results
    results.map(&:as_json).map(&:symbolize_keys)
  end
end
