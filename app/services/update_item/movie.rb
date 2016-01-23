class UpdateItem::Movie < UpdateItem
  private

  def update_item!
    item.update_attributes!(rotten_tomatoes_movie.attributes)
  end

  def rotten_tomatoes_movie
    Immedialist::RottenTomatoes::Movie.find(imdb_id)
  end

  def imdb_id
    Immedialist::TMDB::Movie.find(item.tmdb_id).imdb_id
  end
end
