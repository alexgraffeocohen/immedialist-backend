require 'support/test_query'

class TestQuery::Movie < TestQuery
  def initialize
    @real_movie = build(:real_movie)
    @fake_movie = build(:fake_movie)
    super
  end

  private

  attr_reader :real_movie, :fake_movie

  def real_name
    real_movie.name
  end

  def fake_name
    fake_movie.name
  end

  def real_external_id
    real_movie.tmdb_id
  end

  def fake_external_id
    fake_movie.tmdb_id
  end
end
