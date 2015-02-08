class SaveResultsFromQuery
  def self.call(query_results, item_type)
    new(query_results, item_type).call
  end

  def initialize(query_results, item_type)
    @query_results = query_results
    @item_type = item_type
  end

  def call
    sanitized_results = query_sanitizer_class.call(@query_results)
    return [] if sanitized_results.empty?
    query_saver_class.call(sanitized_results)
  end

  private

  def query_sanitizer_class
    QuerySanitizer.const_get(@item_type.name)
  end

  def query_saver_class
    QuerySaver.const_get(@item_type.name)
  end
end
