class SaveResultsFromQuery
  def self.call(query, item_type)
    new(query, item_type).call
  end

  def initialize(query, item_type)
    @query = query
    @item_type = item_type
  end

  def call
    query.call
    query_saver_class.call(query)
  end

  private

  attr_reader :query

  def query_saver_class
    QuerySaver.const_get(@item_type.name)
  end
end
