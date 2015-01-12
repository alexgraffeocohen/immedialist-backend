class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.string :name
      t.integer :item_id
      t.string :item_type

      t.timestamps null: false
    end
  end
end
