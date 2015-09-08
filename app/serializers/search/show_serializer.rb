class Search::ShowSerializer < SearchSerializer
  has_many :shows

  def shows
    Array(object.results)
  end
end
