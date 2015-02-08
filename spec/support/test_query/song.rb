require 'support/test_query'

class TestQuery::Song < TestQuery
  def initialize
    @real_song = build(:real_song)
    @fake_song = build(:fake_song)
    super
  end

  private

  attr_reader :real_song, :fake_song

  def real_name
    real_song.name
  end

  def fake_name
    fake_song.name
  end

  def real_external_id
    real_song.spotify_id
  end

  def fake_external_id
    fake_song.spotify_id
  end
end
