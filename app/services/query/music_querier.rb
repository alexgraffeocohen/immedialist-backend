class MusicQuerier
  def self.search_by_song_name(name)
    RSpotify::Track.search(name)
  end

  def self.search_by_song_id(external_id)
    RSpotify::Track.find(external_id)
  end

  def self.search_by_artist_name(name)
    RSpotify::Artist.search(name)
  end

  def self.search_by_artist_id(external_id)
    RSpotify::Artist.find(external_id)
  end

  def self.search_by_album_name(name)
    RSpotify::Album.search(name)
  end

  def self.search_by_album_id(external_id)
    RSpotify::Album.find(external_id)
  end
end
