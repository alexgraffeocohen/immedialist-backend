require 'support/test_query'

class TestQuery::Show < TestQuery
  def initialize
    @real_show = build(:real_show)
    @fake_show = build(:fake_show)
    super
  end

  private

  attr_reader :real_show, :fake_show

  def real_name
    real_show.name
  end

  def fake_name
    fake_show.name
  end

  def real_external_id
    real_show.tmdb_id
  end

  def fake_external_id
    fake_show.tmdb_id
  end
end
