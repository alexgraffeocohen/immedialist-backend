class Search::Show < Search
  has_many :results, through: :show_searches, source: :show,
    class_name: '::Show'
  has_many :show_searches, foreign_key: 'search_id', dependent: :destroy
end
