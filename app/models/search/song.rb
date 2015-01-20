class Search::Song < Search
  has_many :results, class_name: Song
end
