class ChangeArtistIdToCreatorIdOnArtistGenres < ActiveRecord::Migration
  def change
    rename_column :artist_genres, :artist_id, :creator_id
  end
end
