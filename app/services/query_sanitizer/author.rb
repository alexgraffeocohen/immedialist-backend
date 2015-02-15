class QuerySanitizer::Author < QuerySanitizer
  private

  def compare_results_to_api_expectations
    results.is_a?(Hashie::Mash) or
      raise TypeError, "Results is not a Hashie object"
    throw(:no_results, []) if results.empty?
  end

  def sanitize_results
    [results.as_json.symbolize_keys]
  end
end
