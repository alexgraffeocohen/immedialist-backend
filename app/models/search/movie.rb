class Search::Movie < Search
  has_many :results, class_name: Movie
end
