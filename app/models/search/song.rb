class Search::Song < Search
  has_many :results, through: :song_searches, source: :song,
    class_name: '::Song'
  has_many :song_searches, foreign_key: 'search_id', dependent: :destroy
end
