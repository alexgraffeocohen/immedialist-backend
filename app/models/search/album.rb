class Search::Album < Search
  has_many :results, through: :album_searches, source: :album
  has_many :album_searches
end
