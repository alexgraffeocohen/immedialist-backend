class DropSongArtistTable < ActiveRecord::Migration
  def change
    drop_table :song_artists
  end
end
