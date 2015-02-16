class RemoveListIdFromListItems < ActiveRecord::Migration
  def change
    remove_column :list_items, :list_id
  end
end
