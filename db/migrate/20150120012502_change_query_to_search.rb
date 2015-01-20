class ChangeQueryToSearch < ActiveRecord::Migration
  def change
    drop_table :queries
    create_table :searches do |t|
      t.string :name
      t.string :type
      t.integer :list_item_id

      t.timestamps null: false
    end
  end
end
