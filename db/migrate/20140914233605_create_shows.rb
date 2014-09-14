class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :title
      t.string :creator
      t.integer :episode_length
      t.date :first_air_date
      t.date :last_air_date
      t.string :status
      t.integer :seasons_count
      t.integer :episodes_count
      t.integer :tmdb_id
      t.text :overview
      t.integer :imdb_id

      t.timestamps
    end
  end
end
