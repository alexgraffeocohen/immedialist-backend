class Search::Song < Search
  has_many :results, through: :song_searches, source: :song
  has_many :song_searches
end
