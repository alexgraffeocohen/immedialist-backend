class ChangeDirectorIdToCreatorIdOnMovieDirectors < ActiveRecord::Migration
  def change
    rename_column :movie_directors, :director_id, :creator_id
  end
end
