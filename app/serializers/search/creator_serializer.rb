class Search::CreatorSerializer < SearchSerializer
  has_many :creators

  def creators
    Array(object.results)
  end
end
