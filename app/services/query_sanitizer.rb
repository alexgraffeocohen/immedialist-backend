class QuerySanitizer
  include ApiExpectations
  include Immedialist::ItemTypeConversion

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

  def sanitize_results
    raise NotImplementedError
  end
end
