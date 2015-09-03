class ChangeMediaNameonRequestedItemsToRequestedType < ActiveRecord::Migration
  def change
    rename_column :requested_items, :media_name, :requested_type
  end
end
