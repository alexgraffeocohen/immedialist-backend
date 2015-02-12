class QuerySaver
  def self.call(results)
    new(results).call
  end

  def initialize(results)
    @results = results
  end

  def call
    build_objects.each(&:save!)
  end

  private
  attr_reader :results

  def build_objects
    raise NotImplementedError
  end
end
