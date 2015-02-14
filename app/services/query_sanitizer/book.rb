class QuerySanitizer::Book < QuerySanitizer
  private

  def compare_results_to_api_expectations
    results.is_a?(Hashie::Mash) or raise TypeError, "Results is not a Hash"
    throw(:no_results, []) if results.total_results == '0'
    book_results_expectations
    book_result_expectations
  end

  def book_results_expectations
    results.results.work.is_a?(Array) or
      raise TypeError, "Book results are not in an array"
  end

  def book_result_expectations
    first_book_result = results.results.work.first.best_book
    first_book_result.is_a?(Hashie::Mash) or
      raise TypeError, "Book result is not a Hashie object"
  end

  def sanitize_results
    book_results = truncate_book_results(results.results.work)
    book_results.map(&:as_json).map(&:symbolize_keys)
  end

  def truncate_book_results(verbose_book_results)
    verbose_book_results.map do |book_result|
      book_result[:best_book]
    end
  end
end
