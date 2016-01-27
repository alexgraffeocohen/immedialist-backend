class UpdateItem::Movie < UpdateItem
  private

  def update_item!
    item.assign_attributes(updated_attributes)
    update_genres!(tmdb_movie, :tmdb_id) if tmdb_movie.genres.present?
    update_actors!(tmdb_movie, :tmdb_id) if tmdb_movie.actors.present?
    item.save!
  end

  def updated_attributes
    rotten_tomatoes_movie.attributes.merge(tmdb_movie.attributes)
  end

  def rotten_tomatoes_movie
    Immedialist::RottenTomatoes::Movie.find(imdb_id)
  end

  def tmdb_movie
    @tmdb_movie ||= Immedialist::TMDB::Movie.find(item.tmdb_id)
  end

  def imdb_id
    tmdb_movie.imdb_id
  end

  def update_genres!(api_resource, api_identifier)
    join_model_name = "#{item.class.name.downcase}_genres"

    api_resource.genres.each do |association_record|
      db_record = Genre.find_by(
        api_identifier => association_record.send(api_identifier)
      )

      if db_record
        item.send(join_model_name).find_or_create_by!(genre: db_record)
      else
        item.genres << Genre.create!(association_record.attributes)
      end
    end
  end

  def update_actors!(api_resource, api_identifier)
    join_model_name = "#{item.class.name.downcase}_actors"

    api_resource.actors.each do |association_record|
      db_record = Creator.find_by(
        api_identifier => association_record.send(api_identifier)
      )

      if db_record
        item.send(join_model_name).find_or_create_by!(creator: db_record)
      else
        item.actors << Creator.create!(association_record.attributes)
      end
    end
  end
end
