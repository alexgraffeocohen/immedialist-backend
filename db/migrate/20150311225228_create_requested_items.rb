class CreateRequestedItems < ActiveRecord::Migration
  def change
    create_table :requested_items do |t|
      t.string :name
      t.string :type

      t.timestamps null: false
    end
  end
end
