class QuerySaver
  def self.call(query)
    new(query).call
  end

  def initialize(query)
    @results = query.results
  end

  def call
    raise NotImplementedError
  end

  private

  attr_reader :results
end
