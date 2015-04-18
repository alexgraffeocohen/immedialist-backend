class Search::Movie < Search
  has_many :results, through: :movie_searches, source: :movie,
    class_name: '::Movie'
  has_many :movie_searches, foreign_key: 'search_id', dependent: :destroy
end
