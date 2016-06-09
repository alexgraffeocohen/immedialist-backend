class UpdateItem::Show < UpdateItem
  private

  def update_item!
    item.assign_attributes(tmdb_show.attributes)
    update_genres!(tmdb_show, :tmdb_id) if tmdb_show.genres.present?
    update_actors!(tmdb_show, :tmdb_id) if tmdb_show.actors.present?
    item.save!
  end

  def tmdb_show
    @tmdb_show ||= Immedialist::TMDB::Show.find(item.tmdb_id)
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
end
