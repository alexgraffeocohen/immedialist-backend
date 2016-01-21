class UpdateItem::Movie < UpdateItem
  private

  def update_item!
    item.update_attributes!(rotten_tomatoes_movie.attributes)
  end

  def rotten_tomatoes_movie
    Immedialist::RottenTomatoes::Movie.find(imdb_id)
  end

  def imdb_id
    sanitized_results.fetch(:imdb_id).gsub(/\D/,"")
  end

  def sanitized_results
    query.call.symbolize_keys
  end

  def query
    query_class.new(external_id: item.tmdb_id)
  end

  def query_class
    Query.const_get(item.class.name, false)
  end
end
