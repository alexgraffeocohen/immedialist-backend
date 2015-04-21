class Search::Author < Search
  has_many :results, through: :author_searches, source: :creator,
    class_name: '::Creator'
  has_many :author_searches, foreign_key: 'search_id', dependent: :destroy
end
