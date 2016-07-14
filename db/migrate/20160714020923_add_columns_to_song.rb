class AddColumnsToSong < ActiveRecord::Migration
  def change
    add_column :songs, :disc_number, :integer
    add_column :songs, :track_number, :integer
  end
end
