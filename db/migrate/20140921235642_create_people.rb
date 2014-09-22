class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :spotify_id
      t.integer :spotify_popularity
      t.string :spotify_url
      t.date :date_of_birth
      t.date :date_of_death

      t.timestamps
    end
  end
end
