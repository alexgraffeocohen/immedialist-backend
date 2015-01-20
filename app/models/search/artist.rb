class Search::Artist < Search
  has_many :results, class_name: Person
end
