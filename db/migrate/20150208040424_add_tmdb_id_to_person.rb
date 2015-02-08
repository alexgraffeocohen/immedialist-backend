class AddTmdbIdToPerson < ActiveRecord::Migration
  def change
    add_column :people, :tmdb_id, :integer
  end
end
