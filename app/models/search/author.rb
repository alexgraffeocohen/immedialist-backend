class Search::Author < Search
  has_many :results, class_name: Person
end
