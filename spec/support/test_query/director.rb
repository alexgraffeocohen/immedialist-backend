require 'support/test_query'

class TestQuery::Director < TestQuery
  def initialize
    @real_director = build(:real_director)
    @director_with_common_name = build(:director_with_common_name)
    @fake_director = build(:fake_director)
    super
  end

  private

  attr_reader :real_director, :director_with_common_name, :fake_director

  def real_name
    real_director.name
  end

  def fake_name
    fake_director.name
  end

  def common_name
    director_with_common_name.name
  end

  def real_external_id
    real_director.tmdb_id
  end

  def fake_external_id
    fake_director.tmdb_id
  end
end
