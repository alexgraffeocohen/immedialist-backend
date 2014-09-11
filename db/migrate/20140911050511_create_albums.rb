class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.date :release_date
      t.string :album_type
      t.integer :spotify_id
      t.integer :spotify_popularity

      t.timestamps
    end
  end
end
