class ChangeTypeofSpotifyIdColumns < ActiveRecord::Migration
  def up
    change_column :songs, :spotify_id, :string
    change_column :albums, :spotify_id, :string
    change_column :artists, :spotify_id, :string
  end

  def down
    change_column :songs,   :spotify_id, :integer
    change_column :albums,  :spotify_id, :integer
    change_column :artists, :spotify_id, :integer
  end
end
