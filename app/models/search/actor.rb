class Search::Actor < Search
  has_many :results, through: :actor_searches, source: :creator,
    class_name: '::Creator'
  has_many :actor_searches, foreign_key: 'search_id', dependent: :destroy
end
