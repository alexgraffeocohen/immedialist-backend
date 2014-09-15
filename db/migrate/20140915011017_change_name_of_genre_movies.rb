class ChangeNameOfGenreMovies < ActiveRecord::Migration
  def change
    rename_table :genre_movies, :movie_genres
  end
end
