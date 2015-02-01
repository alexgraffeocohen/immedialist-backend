class ExecuteQueryForSearch
  def self.call(search, item_type)
    new(search, item_type).call
  end

  def initialize(search, item_type)
    @search = search
    @item_type = item_type
  end

  def call
    query = query_class.new(name: search.name)
    records_from_query = SaveResultsFromQuery.call(query, item_type)
    search.results = records_from_query
    search.save!
  end

  private

  attr_reader :search, :item_type

  def query_class
    Query.const_get(@item_type.name)
  end
end
