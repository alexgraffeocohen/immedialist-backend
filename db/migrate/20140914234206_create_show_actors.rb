class CreateShowActors < ActiveRecord::Migration
  def change
    create_table :show_actors do |t|
      t.integer :show_id
      t.integer :actor_id

      t.timestamps
    end
  end
end
