class CreateSongSearches < ActiveRecord::Migration
  def change
    create_table :song_searches do |t|
      t.integer :song_id
      t.integer :search_id

      t.timestamps null: false
    end
  end
end
