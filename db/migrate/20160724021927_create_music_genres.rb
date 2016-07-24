class CreateMusicGenres < ActiveRecord::Migration
  def change
    create_table :music_genres do |t|
      t.string :name, null: false
      t.string :spotify_id, null: false

      t.timestamps null: false
    end
  end
end
