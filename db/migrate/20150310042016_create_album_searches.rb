class CreateAlbumSearches < ActiveRecord::Migration
  def change
    create_table :album_searches do |t|
      t.integer :album_id
      t.integer :search_id

      t.timestamps null: false
    end
  end
end
