class Search::AlbumSerializer < SearchSerializer
  has_many :albums

  def albums
    Array(object.results)
  end
end
