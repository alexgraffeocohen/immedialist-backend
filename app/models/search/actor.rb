class Search::Actor < Search
  has_many :results, class_name: Creator
end
