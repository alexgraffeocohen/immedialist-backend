class ChangeNameOfActorMovies < ActiveRecord::Migration
  def change
    rename_table :actor_movies, :movie_actors
  end
end
