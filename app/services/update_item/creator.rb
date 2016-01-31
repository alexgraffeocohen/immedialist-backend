class UpdateItem::Creator < UpdateItem
  private

  def update_item!
    sync_with_tmdb! if item.tmdb_id
    item.save!
  end

  def updated_attributes
    tmdb_person.attributes
  end

  def sync_with_tmdb!
    item.assign_attributes(tmdb_person.attributes)
    update_movies_acted_in! if tmdb_person.movies_acted_in.present?
  end

  def tmdb_person
    @tmdb_show ||= Immedialist::TMDB::Person.find(item.tmdb_id)
  end

  def update_movies_acted_in!
    tmdb_person.movies_acted_in.each do |tmdb_movie|
      movie_in_db = ::Movie.find_by(tmdb_id: tmdb_movie.tmdb_id)

      if movie_in_db
        item.movie_actors.find_or_create_by!(movie: movie_in_db)
      else
        item.movies_acted_in << ::Movie.create!(tmdb_movie.attributes)
      end
    end
  end
end
