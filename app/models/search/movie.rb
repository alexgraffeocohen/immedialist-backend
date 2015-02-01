class Search::Movie < Search
  has_many :results, through: :movie_searches, source: :movie
  has_many :movie_searches
end
