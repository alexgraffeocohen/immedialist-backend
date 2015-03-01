class AttachQueryResultsToSearch
  def self.call(search)
    new(search).call
  end

  def initialize(search)
    @search = search
  end

  def call
    search.results = SaveResultsFromQuery.call(query, item_type)
    search.save!
  end

  private

  attr_reader :search

  def item_type
    search.to_item_type
  end

  def query
    query_class.new(name: search.name)
  end

  def query_class
    Query.const_get(item_type.name)
  end
end
