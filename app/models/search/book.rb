class Search::Book < Search
  has_many :results, through: :book_searches, source: :book
  has_many :book_searches
end
