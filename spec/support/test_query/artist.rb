require 'support/test_query'

class TestQuery::Artist < TestQuery
  def initialize
    @real_artist = build(:real_artist)
    @fake_artist = build(:fake_artist)
    super
  end

  private

  attr_reader :real_artist, :fake_artist

  def real_name
    real_artist.name
  end

  def fake_name
    fake_artist.name
  end

  def real_external_id
    real_artist.spotify_id
  end

  def fake_external_id
    fake_artist.spotify_id
  end
end
