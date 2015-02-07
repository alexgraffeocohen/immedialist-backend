require 'support/helpers'

class ActorTester
  include Helpers

  def call_query_with_results
    self.query = query_with_results
    call_query_with_cassette(results_cassette)
  end

  def call_query_with_no_results
    self.query = query_with_no_results
    call_query_with_cassette(no_results_cassette)
  end

  private
  attr_accessor :query

  def query_with_results
    Query::Actor.new(name: "Keanu Reeves")
  end

  def results_cassette
    'real_name_actor_query'
  end

  def query_with_no_results
    Query::Actor.new(name: "There Are No Results For Sure")
  end

  def no_results_cassette
    'no_results_actor_query'
  end
end
