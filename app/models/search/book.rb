class Search::Book < Search
  has_many :results, through: :book_searches, source: :book,
    class_name: '::Book'
  has_many :book_searches, foreign_key: 'search_id', dependent: :destroy
end
