require 'support/test_query'

class TestQuery::Album < TestQuery
  def initialize
    @real_album = build(:real_album)
    @fake_album = build(:fake_album)
    super
  end

  private

  attr_reader :real_album, :fake_album

  def real_name
    real_album.name
  end

  def fake_name
    fake_album.name
  end

  def real_external_id
    real_album.spotify_id
  end

  def fake_external_id
    fake_album.spotify_id
  end
end
