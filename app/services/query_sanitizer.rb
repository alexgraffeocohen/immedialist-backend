class QuerySanitizer
  def self.call(query_results)
    new(query_results).call
  end

  def initialize(query_results)
    @results = query_results
  end

  def call
    compare_results_to_api_expectations
    sanitize_results
  end

  private

  attr_reader :results

  def compare_results_to_api_expectations
    raise NotImplementedError
  end

  def tmdb_person_api_expecations
    results.is_a?(Array) or raise TypeError, "Results is not an array"
    return [] if results.empty?
    results.first.is_a?(Tmdb::Person) or
      raise TypeError, "Result is not a TMDB person object"
  end

  def sanitize_results
    raise NotImplementedError
  end
end
