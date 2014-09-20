class CreateActorCategories < ActiveRecord::Migration
  def change
    create_table :actor_categories do |t|
      t.integer :actor_id
      t.integer :category_id

      t.timestamps
    end
  end
end
