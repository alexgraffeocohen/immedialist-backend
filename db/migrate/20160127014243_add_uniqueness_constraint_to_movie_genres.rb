class AddUniquenessConstraintToMovieGenres < ActiveRecord::Migration
  def up
    change_column :movie_genres, :movie_id, :integer, null: false
    change_column :movie_genres, :genre_id, :integer, null: false

    add_index :movie_genres, [:movie_id, :genre_id], unique: true
    add_foreign_key :movie_genres, :movies
    add_foreign_key :movie_genres, :genres
  end

  def down
    change_column :movie_genres, :movie_id, :integer, null: true
    change_column :movie_genres, :genre_id, :integer, null: true

    remove_index :movie_genres, [:movie_id, :genre_id]
    remove_foreign_key :movie_genres, :movies
    remove_foreign_key :movie_genres, :genres
  end
end
