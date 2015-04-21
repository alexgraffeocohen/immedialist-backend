class Search::Artist < Search
  has_many :results, through: :artist_searches, source: :creator,
    class_name: '::Creator'
  has_many :artist_searches, foreign_key: 'search_id', dependent: :destroy
end
