class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.integer :spotify_id
      t.integer :spotify_popularity
      t.string :spotify_url

      t.timestamps
    end
  end
end
