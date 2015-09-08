class Search::MovieSerializer < SearchSerializer
  has_many :movies

  def movies
    Array(object.results)
  end
end
