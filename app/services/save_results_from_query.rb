class SaveResultsFromQuery
  def self.call(query, item_type)
    new(query, item_type).call
  end

  def initialize(query, item_type)
    @query = query
    @item_type = item_type
  end

  def call
    query_results = @query.call
    query_saver_class.call(query_results)
  end

  private

  def query_saver_class
    QuerySaver.const_get(@item_type.name)
  end
end
