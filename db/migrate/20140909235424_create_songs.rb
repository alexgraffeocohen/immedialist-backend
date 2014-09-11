class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.integer :duration_ms
      t.string :spotify_preview_url
      t.string :spotify_url
      t.integer :spotify_popularity
      t.integer :spotify_id

      t.timestamps
    end
  end
end
