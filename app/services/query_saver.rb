class QuerySaver
  def self.call(results)
    new(results).call
  end

  def initialize(results)
    @results = results
  end

  def call
    raise NotImplementedError
  end

  private

  attr_reader :results
end
