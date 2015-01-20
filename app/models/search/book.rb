class Search::Book < Search
  has_many :results, class_name: Book
end
