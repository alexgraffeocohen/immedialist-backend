class ChangeTypeToMediaNameOnRequestedItems < ActiveRecord::Migration
  def change
    rename_column :requested_items, :type, :media_name
  end
end
