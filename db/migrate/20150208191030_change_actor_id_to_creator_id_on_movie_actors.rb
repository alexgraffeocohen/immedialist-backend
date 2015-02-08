class ChangeActorIdToCreatorIdOnMovieActors < ActiveRecord::Migration
  def change
    rename_column :movie_actors, :actor_id, :creator_id
  end
end
