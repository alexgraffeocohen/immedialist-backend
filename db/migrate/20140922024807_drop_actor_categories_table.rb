class DropActorCategoriesTable < ActiveRecord::Migration
  def change
    drop_table :actor_categories
  end
end
