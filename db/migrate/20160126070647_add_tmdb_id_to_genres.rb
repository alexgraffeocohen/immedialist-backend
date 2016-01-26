class AddTmdbIdToGenres < ActiveRecord::Migration
  def change
    add_column :genres, :tmdb_id, :integer
  end
end
