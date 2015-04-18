class Search::Album < Search
  has_many :results, through: :album_searches, source: :album,
    class_name: '::Album'
  has_many :album_searches, foreign_key: 'search_id'
end
