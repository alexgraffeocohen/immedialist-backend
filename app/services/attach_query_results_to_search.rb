class AttachQueryResultsToSearch
  def self.call(search, item_type)
    new(search, item_type).call
  end

  def initialize(search, item_type)
    @search = search
    @item_type = item_type
  end

  def call
    search.results = SaveResultsFromQuery.call(query, item_type)
    search.save!
  end

  private

  attr_reader :search, :item_type

  def query
    query_class.new(name: search.name)
  end

  def query_class
    Query.const_get(@item_type.name)
  end
end
