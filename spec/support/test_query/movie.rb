require 'support/test_query'

class TestQuery::Movie < TestQuery
  private

  def real_movie
    build(:real_movie)
  end

  def fake_movie
    build(:fake_movie)
  end

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
