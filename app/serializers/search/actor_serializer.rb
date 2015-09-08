class Search::ActorSerializer < SearchSerializer
  has_many :creators

  def creators
    Array(object.results)
  end
end
