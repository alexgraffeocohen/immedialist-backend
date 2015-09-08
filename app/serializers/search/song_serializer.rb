class Search::SongSerializer < SearchSerializer
  has_many :songs

  def songs
    Array(object.results)
  end
end
