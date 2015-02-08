class ChangeActorIdToCreatorIdOnShowActors < ActiveRecord::Migration
  def change
    rename_column :show_actors, :actor_id, :creator_id
  end
end
