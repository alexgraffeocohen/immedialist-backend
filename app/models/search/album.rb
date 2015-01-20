class Search::Album < Search
  has_many :results, class_name: Album
end
