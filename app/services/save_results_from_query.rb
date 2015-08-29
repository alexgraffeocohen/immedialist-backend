class SaveResultsFromQuery
  def self.call(query)
    new(query).call
  end

  def initialize(query)
    @query = query
  end

  def call
    require_services
    query_results = query.call
    sanitized_results = query_sanitizer_class.call(query_results)
    return [] if sanitized_results.empty?
    query_saver_class.call(sanitized_results)
  end

  private

  attr_reader :query

  def item_type
    query.to_item_type
  end

  def query_sanitizer_class
    QuerySanitizer.const_get(item_type.name, false)
  end

  def query_saver_class
    QuerySaver.const_get(item_type.name, false)
  end

  def require_services
    Dir[Rails.root.join("app/services/query_saver/*.rb")].each { |f| require f }
  end
end
