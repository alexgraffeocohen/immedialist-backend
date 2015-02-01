class CreateMovieSearches < ActiveRecord::Migration
  def change
    create_table :movie_searches do |t|
      t.integer :movie_id
      t.integer :search_id

      t.timestamps null: false
    end
  end
end
