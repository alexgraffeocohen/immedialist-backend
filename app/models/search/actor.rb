class Search::Actor < Search
  has_many :results, through: :actor_searches, source: :creator
  has_many :actor_searches
end
