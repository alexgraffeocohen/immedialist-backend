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
end
