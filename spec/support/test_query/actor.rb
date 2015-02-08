require 'support/test_query'

class TestQuery::Actor < TestQuery
  delegate :common_name_fixture, to: :fixture_handler

  def initialize
    @real_actor = build(:real_actor)
    @real_actor_with_common_name = build(:real_actor_with_common_name)
    @fake_actor = build(:fake_actor)
    super
  end

  def call_with_common_name
    self.query = query_class.new(name: common_name)
    call_query_with_fixture(common_name_fixture)
  end

  private

  attr_reader :real_actor, :real_actor_with_common_name, :fake_actor

  def real_name
    real_actor.name
  end

  def fake_name
    fake_actor.name
  end

  def common_name
    real_actor_with_common_name.name
  end

  def real_external_id
    real_actor.tmdb_id
  end

  def fake_external_id
    fake_actor.tmdb_id
  end
end
