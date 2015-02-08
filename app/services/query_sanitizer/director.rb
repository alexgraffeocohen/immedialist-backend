class QuerySanitizer::Director < QuerySanitizer
  private

  def compare_results_to_api_expectations
    tmdb_person_api_expecations
  end

  def sanitize_results
    results.map(&:as_json).map(&:symbolize_keys)
  end
end
