class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :name
      t.string :type
      t.integer :list_item_id

      t.timestamps null: false
    end
  end
end
