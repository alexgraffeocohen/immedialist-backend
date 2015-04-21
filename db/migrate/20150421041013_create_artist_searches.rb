class CreateArtistSearches < ActiveRecord::Migration
  def change
    create_table :artist_searches do |t|
      t.integer :creator_id
      t.integer :search_id

      t.timestamps null: false
    end
  end
end
