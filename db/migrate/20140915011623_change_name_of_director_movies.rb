class ChangeNameOfDirectorMovies < ActiveRecord::Migration
  def change
    rename_table :director_movies, :movie_directors
  end
end
