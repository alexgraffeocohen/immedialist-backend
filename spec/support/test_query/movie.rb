require 'support/test_query'

class TestQuery::Movie < TestQuery
  def call_real_name_query
    self.query = query_class.new(name: real_movie.name)
    call_query_with_cassette(real_name_cassette)
  end

  def call_fake_name_query
    self.query = query_class.new(name: fake_movie.name)
    call_query_with_cassette(fake_name_cassette)
  end

  def call_real_id_query
    self.query = query_class.new(external_id: real_movie.tmdb_id)
    call_query_with_cassette(real_id_cassette)
  end

  def call_fake_id_query
    self.query = query_class.new(external_id: fake_movie.tmdb_id)
    call_query_with_cassette(fake_id_cassette)
  end

  private

  def real_movie
    build(:real_movie)
  end

  def fake_movie
    build(:fake_movie)
  end

  def real_name_cassette
    'real_name_movie_query'
  end

  def fake_name_cassette
    'no_results_movie_query'
  end

  def real_id_cassette
    'real_id_movie_query'
  end

  def fake_id_cassette
    'fake_id_movie_query'
  end
end
