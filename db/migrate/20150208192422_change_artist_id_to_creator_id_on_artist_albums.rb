class ChangeArtistIdToCreatorIdOnArtistAlbums < ActiveRecord::Migration
  def change
    rename_column :artist_albums, :artist_id, :creator_id
  end
end
