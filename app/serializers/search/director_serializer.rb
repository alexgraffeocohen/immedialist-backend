class Search::DirectorSerializer < SearchSerializer
  has_many :creators

  def creators
    Array(object.results)
  end
end
