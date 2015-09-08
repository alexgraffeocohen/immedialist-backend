class Search::BookSerializer < SearchSerializer
  has_many :books

  def books
    Array(object.results)
  end
end
