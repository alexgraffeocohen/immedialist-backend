class AddTotalTracksToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :total_tracks, :integer
  end
end
