class Search::Director < Search
  has_many :results, through: :director_searches, source: :creator,
    class_name: '::Creator'
  has_many :director_searches, foreign_key: 'search_id', dependent: :destroy
end
